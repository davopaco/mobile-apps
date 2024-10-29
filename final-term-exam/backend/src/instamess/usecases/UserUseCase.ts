import HttpLoginUser from "../model/interfaces/http/HttpLoginUser";
import HttpRegisterUser from "../model/interfaces/http/HttpRegisterUser";
import DeviceService from "../services/DeviceService";
import UserService from "../services/UserService";

export default class UserUseCase {
  constructor(
    private readonly userService: UserService,
    private readonly deviceService: DeviceService
  ) {}

  public async login(httpLogin: HttpLoginUser): Promise<string> {
    const user = await this.userService.checkPassword(httpLogin);

    const device = await this.deviceService.getDeviceForToken(
      httpLogin.fcmToken
    );

    const deviceAdded = await this.deviceService.getDeviceFromUser(
      httpLogin.email,
      device
    );

    let result = false;

    if (deviceAdded.isNull()) {
      result = await this.deviceService.addDeviceToUser(
        httpLogin.email,
        device
      );
    } else {
      result = await this.deviceService.updateDeviceToLogged(
        httpLogin.email,
        device.getId()
      );
    }

    if (user && result) {
      return await this.userService.generateJWT(httpLogin.email);
    }

    return "";
  }

  public async register(
    httpRegister: HttpRegisterUser
  ): Promise<{ jwt: string; exists: boolean }> {
    const user = await this.userService.getUser(httpRegister.email);

    if (user.isNull()) {
      const result = await this.userService.addUser(httpRegister);

      const device = await this.deviceService.getDeviceForToken(
        httpRegister.fcmToken
      );

      if (device.isNull()) {
        return { jwt: "", exists: false };
      }

      const resultDevice = await this.deviceService.addDeviceToUser(
        httpRegister.email,
        device
      );

      if (result && resultDevice) {
        return {
          jwt: await this.userService.generateJWT(httpRegister.email),
          exists: false,
        };
      }
      return { jwt: "", exists: false };
    }
    return { jwt: "", exists: true };
  }

  public async logout(email: string, fcmToken: string): Promise<boolean> {
    const device = await this.deviceService.getDeviceForToken(fcmToken);
    const result = await this.deviceService.removeDeviceFromUser(
      email,
      device.getId()
    );

    return result;
  }

  public async getAllUsers() {
    return await this.userService.getAllUsers();
  }
}
