import SqlUserDevice from "../../model/interfaces/sql/SqlUserDevice";
import NUserDevice from "../../model/userDevice/NUserDevice";
import UserDevice from "../../model/userDevice/UserDevice";
import DeviceRepository from "../DeviceRepository";
import UserRepository from "../UserRepository";
import IFactory from "./IFactory";

export default class UserDeviceFactory
  implements IFactory<UserDevice, SqlUserDevice>
{
  public getQuery = "SELECT * FROM USER_has_DEVICE WHERE USER_EMAIL = ?";
  public getAllQuery = "SELECT * FROM USER_has_DEVICE";
  public createQuery =
    "INSERT INTO USER_has_DEVICE (USER_EMAIL, DEVICE_ID, LOGGED) VALUES (?, ?, ?)";

  constructor(
    private readonly userRepository: UserRepository,
    private readonly deviceRepository: DeviceRepository
  ) {}

  async modelFactory(sqlUserDevice: SqlUserDevice): Promise<UserDevice> {
    return new UserDevice(
      await this.userRepository.get(sqlUserDevice.USER_EMAIL),
      await this.deviceRepository.get(sqlUserDevice.DEVICE_ID),
      sqlUserDevice.LOGGED === 1
    );
  }
  nullModelFactory(): UserDevice {
    return new NUserDevice();
  }

  setCreateParams(userDevice: UserDevice): any[] {
    return [
      userDevice.getUser().getEmail(),
      userDevice.getDevice().getId(),
      userDevice.isLogged(),
    ];
  }
}
