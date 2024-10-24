import { ResultSetHeader } from "mysql2";
import MySqlDBC from "../../util/database/MySqlDBC";
import SqlUsers from "../model/sql/SqlUser";
import User from "../model/user/User";
import NUser from "../model/user/NUser";

export default class UserRepository {
  constructor(private readonly connection: MySqlDBC) {}

  public async get(username: string): Promise<User> {
    try {
      const sql = `SELECT * FROM USERS WHERE USERNAME = ?`;
      const rows = await this.connection.query<SqlUsers>(sql, [username]);
      if (rows.length === 0) {
        return new NUser();
      }
      const dbUser = rows[0];
      return new User(dbUser.USERNAME, dbUser.NAME, dbUser.HASH);
    } catch (error) {
      console.error(error);
      return new NUser();
    }
  }

  public async getAll(): Promise<User[]> {
    try {
      const sql = `SELECT * FROM USERS`;
      const rows = await this.connection.query<SqlUsers>(sql);
      if (rows.length === 0) {
        return [];
      }
      return rows.map(
        (row) =>
          new User(row.ID, row.NAME, row.VENDOR, row.RATING, row.IMAGE_PATH)
      );
    } catch (error) {
      console.error(error);
      return [];
    }
  }

  public async create(user: User): Promise<boolean> {
    try {
      const sql = `INSERT INTO USERS (USERNAME, NAME, HASH) VALUES (?, ?, ?)`;
      const result = await this.connection.query<ResultSetHeader>(sql, [
        user.getEmail(),
        user.getName(),
        user.getHash(),
      ]);

      if (result[0].affectedRows > 0) {
        return true;
      }
      return false;
    } catch (error) {
      console.error(error);
      return false;
    }
  }
}
