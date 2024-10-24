import MySqlDBC from "../../util/database/MySqlDBC";
import Item from "../model/item/Item";
import SqlItems from "../model/sql/SqlItems";
import NItem from "../model/item/NItem";
import { ResultSetHeader } from "mysql2";

export default class MessageRepository {
  constructor(private readonly connection: MySqlDBC) {}

  public async get(id: number): Promise<Item> {
    try {
      const sql = `SELECT * FROM ITEMS WHERE ID = ?`;
      const rows = await this.connection.query<SqlItems>(sql, [id]);
      if (rows.length === 0) {
        return new NItem();
      }
      const dbItem = rows[0];
      return new Item(
        dbItem.ID,
        dbItem.NAME,
        dbItem.VENDOR,
        dbItem.RATING,
        dbItem.IMAGE_PATH
      );
    } catch (error) {
      console.error(error);
      return new NItem();
    }
  }

  public async getAll(): Promise<Item[]> {
    try {
      const sql = `SELECT * FROM ITEMS`;
      const rows = await this.connection.query<SqlItems>(sql);
      if (rows.length === 0) {
        return [];
      }
      return rows.map(
        (row) =>
          new Item(row.ID, row.NAME, row.VENDOR, row.RATING, row.IMAGE_PATH)
      );
    } catch (error) {
      console.error(error);
      return [];
    }
  }

  public async create(item: Item): Promise<boolean> {
    try {
      const sql = `INSERT INTO ITEMS (NAME, VENDOR, RATING, IMAGE_PATH) VALUES (?, ?, ?, ?)`;
      const result = await this.connection.query<ResultSetHeader>(sql, [
        item.getName(),
        item.getVendor(),
        item.getRating(),
        item.getImagePath(),
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
