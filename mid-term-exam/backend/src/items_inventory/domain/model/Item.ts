export default class Item {
  private id: number;
  private name: string;
  private vendor: string;
  private rating: number;
  private imagePath: string;

  constructor(
    id: number,
    name: string,
    vendor: string,
    rating: number,
    imagePath: string
  ) {
    this.id = id;
    this.name = name;
    this.vendor = vendor;
    this.rating = rating;
    this.imagePath = imagePath;
  }

  getId(): number {
    return this.id;
  }

  getName(): string {
    return this.name;
  }

  getVendor(): string {
    return this.vendor;
  }

  getRating(): number {
    return this.rating;
  }

  getImagePath(): string {
    return this.imagePath;
  }
}
