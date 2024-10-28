import { ResultSetHeader } from "mysql2";
import SqlUserDevice from "../model/interfaces/sql/SqlUserDevice";
import UserDevice from "../model/userDevice/UserDevice";
import ARepository from "./ARepository";

export default class UserDeviceRepository extends ARepository<
  UserDevice,
  string,
  SqlUserDevice
> {
  async getAllActiveDevicesByUserEmail(email: string): Promise<UserDevice[]> {
    try {
      const sql = `SELECT * FROM USER_has_DEVICE WHERE LOGGED = 1 AND USER_EMAIL = ?`;
      return await this.connection
        .query<SqlUserDevice>(sql, [email])
        .then((rows) => {
          return Promise.all(
            rows.map((row) => this.modelFactory.modelFactory(row))
          );
        });
    } catch (error) {
      console.error("Error fetching devices by user email:", error);
      return Promise.resolve([]);
    }
  }

  async removeDeviceFromUser(
    email: string,
    deviceId: number
  ): Promise<boolean> {
    const sql =
      "UPDATE USER_has_DEVICE SET LOGGED = 0 WHERE USER_EMAIL = ? AND DEVICE_ID = ?";
    const result = await this.connection.query<ResultSetHeader>(sql, [
      email,
      deviceId,
    ]);
    return result[0].affectedRows === 1;
  }
}
