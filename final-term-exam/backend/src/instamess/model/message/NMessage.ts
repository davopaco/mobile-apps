import NUser from "../user/NUser";
import AMessage from "./AMessage";

export default class NMessage extends AMessage {
  constructor() {
    super(
      -1,
      "No title found in the database",
      "No content found in the database",
      "00:00:00",
      new Date(),
      new NUser()
    );
  }

  public isNull(): boolean {
    return true;
  }
}
