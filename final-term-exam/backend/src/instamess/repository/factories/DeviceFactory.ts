import Device from "../../model/device/Device";
import NDevice from "../../model/device/NDevice";
import SqlDevice from "../../model/interfaces/sql/SqlDevice";
import IFactory from "./IFactory";

export default class DeviceFactory implements IFactory<Device, SqlDevice> {
  public getQuery = "SELECT * FROM DEVICE WHERE ID = ?";
  public getAllQuery = "SELECT * FROM DEVICE";
  public createQuery = "INSERT INTO DEVICE (FCM_TOKEN) VALUES (?)";

  async modelFactory(sqlDevice: SqlDevice): Promise<Device> {
    if (sqlDevice === null || sqlDevice === undefined) return new NDevice();
    return new Device(sqlDevice.ID, sqlDevice.FCM_TOKEN);
  }

  nullModelFactory(): Device {
    return new NDevice();
  }

  setCreateParams(device: Device): any[] {
    return [device.getFcmToken()];
  }
}
