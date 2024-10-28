import Device from "../device/Device";
import Message from "../message/Message";

export default abstract class ADeviceMessage {
  constructor(
    protected device: Device,
    protected message: Message,
    protected response: string
  ) {}

  public getDevice(): Device {
    return this.device;
  }

  public getMessage(): Message {
    return this.message;
  }

  public getResponse(): string {
    return this.response;
  }

  public setDevice(device: Device): void {
    this.device = device;
  }

  public setMessage(message: Message): void {
    this.message = message;
  }

  public setResponse(response: string): void {
    this.response = response;
  }

  public abstract isNull(): boolean;
}
