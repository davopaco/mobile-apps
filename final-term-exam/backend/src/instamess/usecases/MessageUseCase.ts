import ErrorMessage from "../model/interfaces/ErrorMessage";
import HttpUserMessage from "../model/interfaces/http/incoming/HttpUserMessage";
import Message from "../model/message/Message";
import MessageService from "../services/MessageService";

export default class MessageUseCase {
  constructor(private readonly messageService: MessageService) {}

  public async getAllMessagesForUser(email: string): Promise<Message[]> {
    const messages = await this.messageService.getMessagesForUser(email);
    if (messages.length === 0) {
      return [];
    }
    return messages;
  }

  public async sendMessage(message: HttpUserMessage): Promise<ErrorMessage> {
    try {
      return await this.messageService.addMessage(message);
    } catch (e) {
      console.log(e);
      return {
        error: true,
        message: "There was an error while sending the message. Try again!",
      };
    }
  }
}
