export default abstract class AItem {
  private id: number;
  private price: string;
  private name: string;
  private discount: string;
  private imagePath: string;
  private rating: string;
  private description: string;
  private ratingsQuantity: string;

  constructor({
    id,
    price,
    name,
    discount,
    imagePath,
    rating,
    description,
    ratingsQuantity,
  }: {
    id: number;
    price: string;
    name: string;
    discount: string;
    imagePath: string;
    rating: string;
    description: string;
    ratingsQuantity: string;
  }) {
    this.id = id;
    this.price = price;
    this.name = name;
    this.discount = discount;
    this.imagePath = imagePath;
    this.rating = rating;
    this.description = description;
    this.ratingsQuantity = ratingsQuantity;
  }

  public getId(): number {
    return this.id;
  }
  public getPrice(): string {
    return this.price;
  }
  public getName(): string {
    return this.name;
  }
  public getDiscount(): string {
    return this.discount;
  }
  public getImagePath(): string {
    return this.imagePath;
  }
  public getRating(): string {
    return this.rating;
  }
  public getDescription(): string {
    return this.description;
  }
  public getRatingsQuantity(): string {
    return this.ratingsQuantity;
  }

  public setId(id: number): void {
    this.id = id;
  }
  public setPrice(price: string): void {
    this.price = price;
  }
  public setName(name: string): void {
    this.name = name;
  }
  public setDiscount(discount: string): void {
    this.discount = discount;
  }
  public setImagePath(imagePath: string): void {
    this.imagePath = imagePath;
  }
  public setRating(rating: string): void {
    this.rating = rating;
  }
  public setDescription(description: string): void {
    this.description = description;
  }
  public setRatingsQuantity(ratingsQuantity: string): void {
    this.ratingsQuantity = ratingsQuantity;
  }

  abstract isNull(): boolean;
}
