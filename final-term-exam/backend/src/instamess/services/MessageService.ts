import Firebase from "../../util/firebase/Firebase";
import DeviceMessage from "../model/deviceMessage/DeviceMessage";
import ErrorMessage from "../model/interfaces/ErrorMessage";
import HttpUserMessage from "../model/interfaces/http/request/HttpUserMessage";
import Message from "../model/message/Message";
import DeviceMessageRepository from "../repository/DeviceMessageRepository";
import MessageRepository from "../repository/MessageRepository";
import UserDeviceRepository from "../repository/UserDeviceRepository";
import UserRepository from "../repository/UserRepository";

export default class MessageService {
  constructor(
    private readonly deviceMessageRepository: DeviceMessageRepository,
    private readonly messageRepository: MessageRepository,
    private readonly firebase: Firebase,
    private readonly userDeviceRepository: UserDeviceRepository,
    private readonly userRepository: UserRepository
  ) {}

  public async getMessagesForUser(email: string): Promise<Message[]> {
    const messages = await this.messageRepository.getMessagesByUserEmail(email);
    return messages;
  }

  public async addMessage(userMessage: HttpUserMessage): Promise<ErrorMessage> {
    //Get all devices for the user that are currently logged in
    const userDevices =
      await this.userDeviceRepository.getAllActiveDevicesByUserEmail(
        userMessage.recipientEmail
      );

    if (userDevices.length === 0)
      return { error: true, message: "No devices for the user were found" };

    const currentDate = new Date();
    const senderUser = await this.userRepository.get(userMessage.email);
    const recipientUser = await this.userRepository.get(
      userMessage.recipientEmail
    );

    const message = new Message(
      0, // This is a placeholder value, it will be replaced by the database
      userMessage.title,
      userMessage.content,
      currentDate,
      senderUser,
      recipientUser
    );

    console.log(message);

    const messageBool = await this.messageRepository.create(message);

    if (!messageBool.created)
      return { error: true, message: "Message could not be created" };

    message.setId(messageBool.lastIdInserted);

    const devicesMessageBools = userDevices.map(async (userDevice) => {
      const deviceMessage = new DeviceMessage(
        userDevice.getDevice(),
        message,
        "No response yet" // This is a placeholder value, it will be replaced after the message is sent
      );

      const firebaseMessage =
        this.firebase.convertDeviceMessageToFirebaseMessage(deviceMessage);

      const response = await this.firebase
        .getFirebaseApp()
        .messaging()
        .send(firebaseMessage);

      deviceMessage.setResponse(response);

      return await this.deviceMessageRepository.create(deviceMessage);
    });

    let trueCount = 0;
    let falseCount = 0;

    devicesMessageBools.forEach(async (deviceMessageBool) => {
      if (await deviceMessageBool) trueCount++;
      else {
        falseCount++;
      }
    });

    if (trueCount === userDevices.length)
      return { error: false, message: "Message sent to all devices" };
    else if (falseCount === userDevices.length)
      return { error: true, message: "Message not sent to any devices" };
    else
      return {
        error: false,
        message: `Message sent to ${trueCount} devices out of ${userDevices.length}`,
      };
  }
}
