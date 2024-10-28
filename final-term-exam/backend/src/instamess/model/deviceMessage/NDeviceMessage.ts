import NDevice from "../device/NDevice";
import NMessage from "../message/NMessage";
import ADeviceMessage from "./ADeviceMessage";

export default class NDeviceMessage extends ADeviceMessage {
  constructor() {
    super(new NDevice(), new NMessage(), "No response found on database.");
  }

  public isNull(): boolean {
    return true;
  }
}
