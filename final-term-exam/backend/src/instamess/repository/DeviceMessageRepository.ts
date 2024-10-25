import DeviceMessage from "../model/deviceMessage/DeviceMessage";
import SqlDeviceMessage from "../model/sql/SqlDeviceMessage";
import ARepository from "./ARepository";

export default class DeviceMessageRepository extends ARepository<
  DeviceMessage,
  number,
  SqlDeviceMessage
> {
  async getDeviceMessagesByUserEmail(
    userEmail: string
  ): Promise<DeviceMessage[]> {
    try {
      const sql = `SELECT DM.* FROM DEVICE_has_MESSAGE DM JOIN DEVICE D ON DM.DEVICE_ID = D.ID WHERE D.USER_EMAIL = ?`;
      return await this.connection.query(sql, [userEmail]);
    } catch (error) {
      console.error("Error fetching device messages by user email:", error);
      return [];
    }
  }
}
