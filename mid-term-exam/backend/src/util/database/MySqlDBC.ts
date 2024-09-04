import mysql, {
  RowDataPacket,
  Pool,
  PoolConnection,
  ResultSetHeader,
} from "mysql2/promise";
import MySqlConnectionConfig from "./types/ConnectionInterface";

export default class MySqlDBC {
  private mySqlConnectionConfig: MySqlConnectionConfig;
  private pool: Pool;

  constructor(mySqlConnectionConfig: MySqlConnectionConfig) {
    this.mySqlConnectionConfig = mySqlConnectionConfig;
    this.pool = mysql.createPool(this.mySqlConnectionConfig);
  }

  async query<T>(sql: string, values?: any[]): Promise<T[]> {
    let connection: PoolConnection | null = null;
    try {
      connection = await this.pool.getConnection();
      const [rows, _fields] = await connection.execute<
        RowDataPacket[] | ResultSetHeader
      >(sql, values);

      if (Array.isArray(rows)) {
        return rows as T[];
      } else {
        return [rows] as T[];
      }
    } catch (error) {
      console.error("Error executing query", error);
      throw error;
    } finally {
      if (connection) connection.release(); // Ensure the connection is released
    }
  }

  async closePool() {
    await this.pool.end();
  }
}
