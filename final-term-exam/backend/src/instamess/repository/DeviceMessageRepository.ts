import DeviceMessage from "../model/deviceMessage/DeviceMessage";
import SqlDeviceMessage from "../model/interfaces/sql/SqlDeviceMessage";
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
      const sql = `SELECT DM.* FROM DEVICE_has_MESSAGE DM JOIN DEVICE D ON DM.DEVICE_ID = D.ID JOIN MESSAGE M ON DM.MESSAGE_ID = M.ID WHERE USER_ORIGIN_EMAIL = ?;`;
      const result = await this.connection.query<SqlDeviceMessage>(sql, [
        userEmail,
      ]);
      const deviceMessages = await Promise.all(
        result.map((sqlDeviceMessage) =>
          this.modelFactory.modelFactory(sqlDeviceMessage)
        )
      );
      return deviceMessages;
    } catch (error) {
      console.error("Error fetching device messages by user email:", error);
      return [];
    }
  }
}
