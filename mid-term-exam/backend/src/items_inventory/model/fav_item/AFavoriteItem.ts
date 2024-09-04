import Item from "../item/Item";
import User from "../user/User";

export default abstract class AFavoriteItem {
  private user: User;
  private item: Item;

  constructor(user: User, item: Item) {
    this.user = user;
    this.item = item;
  }

  getUser(): User {
    return this.user;
  }

  getItem(): Item {
    return this.item;
  }

  setItem(item: Item): void {
    this.item = item;
  }

  setUser(user: User): void {
    this.user = user;
  }

  abstract isNull(): boolean;
}
