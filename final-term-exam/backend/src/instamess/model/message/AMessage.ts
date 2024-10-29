import User from "../user/User";

export default abstract class AMessage {
  constructor(
    protected id: number,
    protected title: string,
    protected content: string,
    protected date: Date,
    protected senderUser: User
  ) {}

  public getId(): number {
    return this.id;
  }

  public getTitle(): string {
    return this.title;
  }

  public getContent(): string {
    return this.content;
  }

  public getDate(): Date {
    return this.date;
  }

  public getSenderUser(): User {
    return this.senderUser;
  }

  public setId(id: number): void {
    this.id = id;
  }

  public setTitle(title: string): void {
    this.title = title;
  }

  public setContent(content: string): void {
    this.content = content;
  }

  public setDate(date: Date): void {
    this.date = date;
  }

  public setSenderUser(senderUser: User): void {
    this.senderUser = senderUser;
  }

  public abstract isNull(): boolean;
}
