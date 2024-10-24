import Device from "../device/Device";
import Message from "../message/Message";

export default abstract class ADeviceMessage {
  constructor(protected device: Device, protected message: Message) {}

  public getDevice(): Device {
    return this.device;
  }

  public getMessage(): Message {
    return this.message;
  }

  public setDevice(device: Device): void {
    this.device = device;
  }

  public setMessage(message: Message): void {
    this.message = message;
  }

  public abstract isNull(): boolean;
}
