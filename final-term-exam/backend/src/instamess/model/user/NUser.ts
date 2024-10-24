import NPosition from "../position/NPosition";
import AUser from "./AUser";

export default class NUser extends AUser {
  constructor() {
    super(
      "Email not found",
      "Name not found",
      "Hash not found",
      new NPosition(),
      "Pfp not found",
      0
    );
  }

  isNull(): boolean {
    return true;
  }
}
