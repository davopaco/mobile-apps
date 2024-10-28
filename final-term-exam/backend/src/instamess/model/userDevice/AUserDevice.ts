import Device from "../device/Device";
import User from "../user/User";

export default abstract class AUserDevice {
  constructor(
    protected user: User,
    protected device: Device,
    protected logged: boolean
  ) {}

  public getUser(): User {
    return this.user;
  }

  public getDevice(): Device {
    return this.device;
  }

  public isLogged(): boolean {
    return this.logged;
  }

  public setUser(user: User): void {
    this.user = user;
  }

  public setDevice(device: Device): void {
    this.device = device;
  }

  public setLogged(logged: boolean): void {
    this.logged = logged;
  }

  public abstract isNull(): boolean;
}
