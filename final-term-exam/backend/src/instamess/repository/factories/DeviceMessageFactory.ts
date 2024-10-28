import DeviceMessage from "../../model/deviceMessage/DeviceMessage";
import NDeviceMessage from "../../model/deviceMessage/NDeviceMessage";
import SqlDeviceMessage from "../../model/interfaces/sql/SqlDeviceMessage";
import DeviceRepository from "../DeviceRepository";
import MessageRepository from "../MessageRepository";
import IFactory from "./IFactory";

export default class DeviceMessageFactory
  implements IFactory<DeviceMessage, SqlDeviceMessage>
{
  public getQuery = "SELECT * FROM DEVICE_has_MESSAGE WHERE MESSAGE_ID = ?";
  public getAllQuery = "SELECT * FROM DEVICE_has_MESSAGE";
  public createQuery =
    "INSERT INTO DEVICE_has_MESSAGE (DEVICE_ID, MESSAGE_ID, RESPONSE) VALUES (?, ?, ?)";

  constructor(
    private readonly deviceRepository: DeviceRepository,
    private readonly messageRepository: MessageRepository
  ) {}

  async modelFactory(
    sqlDeviceMessage: SqlDeviceMessage
  ): Promise<DeviceMessage> {
    return new DeviceMessage(
      await this.deviceRepository.get(sqlDeviceMessage.DEVICE_ID),
      await this.messageRepository.get(sqlDeviceMessage.MESSAGE_ID),
      sqlDeviceMessage.RESPONSE
    );
  }

  nullModelFactory(): DeviceMessage {
    return new NDeviceMessage();
  }

  setCreateParams(deviceMessage: DeviceMessage): any[] {
    return [
      deviceMessage.getDevice().getId(),
      deviceMessage.getMessage().getId(),
      deviceMessage.getResponse(),
    ];
  }
}
