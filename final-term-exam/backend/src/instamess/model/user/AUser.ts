import Position from "../position/Position";

export default abstract class AUser {
  constructor(
    protected email: string,
    protected name: string,
    protected hash: string,
    protected position: Position,
    protected pfp: Buffer,
    protected imageType: string,
    protected phone: number
  ) {}

  getEmail(): string {
    return this.email;
  }

  getName(): string {
    return this.name;
  }

  getHash(): string {
    return this.hash;
  }

  getPosition(): Position {
    return this.position;
  }

  getPfp(): Buffer {
    return this.pfp;
  }

  getPhone(): number {
    return this.phone;
  }

  getImageType(): string {
    return this.imageType;
  }

  setEmail(email: string): void {
    this.email = email;
  }

  setName(name: string): void {
    this.name = name;
  }

  setHash(hash: string): void {
    this.hash = hash;
  }

  setPosition(position: Position): void {
    this.position = position;
  }

  setPfp(pfp: Buffer): void {
    this.pfp = pfp;
  }

  setPhone(phone: number): void {
    this.phone = phone;
  }

  setImageType(imageType: string): void {
    this.imageType = imageType;
  }

  abstract isNull(): boolean;
}
