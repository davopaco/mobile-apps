export default abstract class AMessage {
  constructor(
    protected id: number,
    protected title: string,
    protected content: string,
    protected time: string,
    protected date: Date
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

  public getTime(): string {
    return this.time;
  }

  public getDate(): Date {
    return this.date;
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

  public setTime(time: string): void {
    this.time = time;
  }

  public setDate(date: Date): void {
    this.date = date;
  }

  public abstract isNull(): boolean;
}
