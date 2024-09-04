export default class FavoriteItem {
  private _username: string;
  private _itemId: number;

  constructor(username: string, itemId: number) {
    this._username = username;
    this._itemId = itemId;
  }

  get username(): string {
    return this._username;
  }

  get itemId(): number {
    return this._itemId;
  }
}
