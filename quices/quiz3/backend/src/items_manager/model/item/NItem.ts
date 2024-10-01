import AItem from "./AItem";

export default class NItem extends AItem {
  constructor() {
    super({
      id: -1,
      price: "",
      name: "",
      discount: "",
      imagePath: "",
      rating: "",
      description: "",
      ratingsQuantity: "",
    });
  }

  isNull(): boolean {
    return true;
  }
}
