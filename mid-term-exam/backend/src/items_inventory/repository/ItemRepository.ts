import MySqlDBC from "../../util/database/MySqlDBC";
import Item from "../domain/model/item/Item";
import SqlItems from "../domain/model/sql/SqlItems";
import NItem from "../domain/model/item/NItem";

export default class ItemRepository {
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
}
