import AItem from "./AItem";

export default class NItem extends AItem {
  constructor() {
    super(-1, "Name not found", "Vendor not found", -1, "Image path not found");
  }

  isNull(): boolean {
    return true;
  }

  setId(): void {
    return;
  }

  setName(): void {
    return;
  }

  setVendor(): void {
    return;
  }

  setRating(): void {
    return;
  }

  setImagePath(): void {
    return;
  }
}
