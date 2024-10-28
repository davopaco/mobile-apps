import multer from "multer";

export default class Multer {
  private readonly multer;

  constructor() {
    this.multer = multer;
  }

  public getUpload(): multer.Multer {
    return this.multer({ storage: this.multer.memoryStorage() });
  }
}
