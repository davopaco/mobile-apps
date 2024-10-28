import Device from "../model/device/Device";
import SqlDevice from "../model/interfaces/sql/SqlDevice";
import ARepository from "./ARepository";

export default class DeviceRepository extends ARepository<
  Device,
  number,
  SqlDevice
> {
  async getDeviceForToken(token: string): Promise<Device> {
    const sql = `SELECT * FROM DEVICE WHERE FCM_TOKEN = ?`;
    const result = await this.connection.query<SqlDevice>(sql, [token]);
    return this.modelFactory.modelFactory(result[0]);
  }
}
