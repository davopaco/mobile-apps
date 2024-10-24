import User from "../user/User";

export default abstract class ADevice {
  constructor(
    protected id: number,
    protected fcmToken: string,
    protected user: User,
    protected logged: boolean
  ) {}

  public getId(): number {
    return this.id;
  }

  public getFcmToken(): string {
    return this.fcmToken;
  }

  public getUser(): User {
    return this.user;
  }

  public isLogged(): boolean {
    return this.logged;
  }

  public setId(id: number): void {
    this.id = id;
  }

  public setFcmToken(fcmToken: string): void {
    this.fcmToken = fcmToken;
  }

  public setUser(user: User): void {
    this.user = user;
  }

  public setLogged(logged: boolean): void {
    this.logged = logged;
  }

  public abstract isNull(): boolean;
}
