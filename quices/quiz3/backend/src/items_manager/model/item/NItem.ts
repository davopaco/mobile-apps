import AItem from "./AItem";

export default class NItem extends AItem {
  constructor() {
    super("", "", "", "", "", "", "");
  }

  isNull(): boolean {
    return true;
  }
}
