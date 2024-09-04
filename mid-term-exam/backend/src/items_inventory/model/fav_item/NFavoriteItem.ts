import NItem from "../item/NItem";
import NUser from "../user/NUser";
import AFavoriteItem from "./AFavoriteItem";

export default class NFavoriteItem extends AFavoriteItem {
  constructor() {
    super(new NUser(), new NItem());
  }

  isNull(): boolean {
    return true;
  }

  setUser(): void {
    return;
  }

  setItem(): void {
    return;
  }
}
