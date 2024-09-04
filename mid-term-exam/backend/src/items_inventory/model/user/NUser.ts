import AUser from "./AUser";

export default class NUser extends AUser {
  constructor() {
    super("Username not found", "Name not found", "Hash not found");
  }

  isNull(): boolean {
    return true;
  }

  setHash(): void {
    return;
  }

  setName(): void {
    return;
  }

  setUsername(): void {
    return;
  }
}
