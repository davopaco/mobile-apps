export default abstract class ADevice {
  constructor(protected id: number, protected fcmToken: string) {}

  public getId(): number {
    return this.id;
  }

  public getFcmToken(): string {
    return this.fcmToken;
  }

  public setId(id: number): void {
    this.id = id;
  }

  public setFcmToken(fcmToken: string): void {
    this.fcmToken = fcmToken;
  }

  public abstract isNull(): boolean;
}
