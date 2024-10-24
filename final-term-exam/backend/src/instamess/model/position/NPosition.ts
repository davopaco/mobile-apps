import APosition from "./APosition";

export default class NPosition extends APosition {
  constructor() {
    super(-1, "Name not found");
  }

  isNull(): boolean {
    return true;
  }
}
