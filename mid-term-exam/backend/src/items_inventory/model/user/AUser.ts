export default abstract class AUser {
  private username: string;
  private name: string;
  private hash: string;

  constructor(username: string, name: string, hash: string) {
    this.username = username;
    this.name = name;
    this.hash = hash;
  }

  getUsername(): string {
    return this.username;
  }

  getName(): string {
    return this.name;
  }

  getHash(): string {
    return this.hash;
  }

  setUsername(username: string): void {
    this.username = username;
  }

  setName(name: string): void {
    this.name = name;
  }

  setHash(hash: string): void {
    this.hash = hash;
  }

  abstract isNull(): boolean;
}
