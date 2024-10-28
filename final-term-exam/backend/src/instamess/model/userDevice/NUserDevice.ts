import NDevice from "../device/NDevice";
import NUser from "../user/NUser";
import AUserDevice from "./AUserDevice";

export default class NUserDevice extends AUserDevice {
  constructor() {
    super(new NUser(), new NDevice(), false);
  }

  public isNull(): boolean {
    return true;
  }
}
