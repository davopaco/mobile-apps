import NDevice from "../device/NDevice";
import NMessage from "../message/NMessage";
import ADeviceMessage from "./ADeviceMessage";

export default class NDeviceMessage extends ADeviceMessage {
  constructor() {
    super(new NDevice(), new NMessage());
  }

  public isNull(): boolean {
    return true;
  }
}
