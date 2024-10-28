import ADevice from "./ADevice";

export default class NDevice extends ADevice {
  constructor() {
    super(-1, "No FCM Token found in the database.");
  }

  isNull(): boolean {
    return true;
  }
}
