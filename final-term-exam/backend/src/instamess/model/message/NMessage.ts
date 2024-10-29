import NUser from "../user/NUser";
import AMessage from "./AMessage";

export default class NMessage extends AMessage {
  constructor() {
    super(
      -1,
      "No title found in the database",
      "No content found in the database",
      new Date(),
      new NUser(),
      new NUser()
    );
  }

  public isNull(): boolean {
    return true;
  }
}
