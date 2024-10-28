import Device from "../model/device/Device";
import NDevice from "../model/device/NDevice";
import UserDevice from "../model/userDevice/UserDevice";
import DeviceRepository from "../repository/DeviceRepository";
import UserDeviceRepository from "../repository/UserDeviceRepository";
import UserRepository from "../repository/UserRepository";

export default class DeviceService {
  constructor(
    private readonly userRepository: UserRepository,
    private readonly deviceRepository: DeviceRepository,
    private readonly userDeviceRepository: UserDeviceRepository
  ) {}

  public async getDeviceForToken(token: string): Promise<Device> {
    const devForToken = await this.deviceRepository.getDeviceForToken(token);
    if (devForToken.isNull()) {
      const device = new Device(0, token);
      const result = await this.deviceRepository.create(device);
      if (result) {
        return await this.deviceRepository.getDeviceForToken(token);
      }
    }
    return new NDevice();
  }

  public async addDeviceToUser(
    email: string,
    deviceId: number
  ): Promise<boolean> {
    const user = await this.userRepository.get(email);
    const device = await this.deviceRepository.get(deviceId);

    if (user.isNull() || device.isNull()) {
      return false;
    }

    return await this.userDeviceRepository.create(
      new UserDevice(user, device, true)
    );
  }

  public async removeDeviceFromUser(
    email: string,
    deviceId: number
  ): Promise<boolean> {
    return await this.userDeviceRepository.removeDeviceFromUser(
      email,
      deviceId
    );
  }
}
