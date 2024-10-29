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
    return devForToken;
  }

  public async getDeviceFromUser(
    email: string,
    device: Device
  ): Promise<Device> {
    const userDevices =
      await this.userDeviceRepository.getAllActiveDevicesByUserEmail(email);
    if (userDevices.length === 0) {
      return new NDevice();
    }
    const userDevice = userDevices.find(
      (ud) => ud.getDevice().getId() === device.getId()
    );
    if (!userDevice) {
      return new NDevice();
    }
    return userDevice.getDevice();
  }

  public async addDeviceToUser(
    email: string,
    device: Device
  ): Promise<boolean> {
    const user = await this.userRepository.get(email);

    if (user.isNull() || device.isNull()) {
      return false;
    }

    const userDevice = await this.userDeviceRepository.getDual(
      email,
      device.getId()
    );

    if (userDevice.isNull()) {
      return await this.userDeviceRepository.create(
        new UserDevice(user, device, true)
      );
    }

    return await this.userDeviceRepository.updateToLogged(
      email,
      device.getId()
    );
  }

  public async updateDeviceToLogged(
    email: string,
    deviceId: number
  ): Promise<boolean> {
    return await this.userDeviceRepository.updateToLogged(email, deviceId);
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
