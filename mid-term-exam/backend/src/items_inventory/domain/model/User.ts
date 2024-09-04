export default class User {
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
}
