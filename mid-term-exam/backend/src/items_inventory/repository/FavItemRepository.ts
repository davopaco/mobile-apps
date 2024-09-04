import { ResultSetHeader } from "mysql2";
import MySqlDBC from "../../util/database/MySqlDBC";
import FavoriteItem from "../domain/model/fav_item/FavoriteItem";
import Item from "../domain/model/item/Item";
import UserRepository from "./UserRepository";
import SqlItems from "../domain/model/sql/SqlItems";
import User from "../domain/model/user/User";

export default class FavItemRepository {
  constructor(
    private readonly connection: MySqlDBC,
    private readonly userRepository: UserRepository
  ) {}

  public async getForUser(username: string): Promise<FavoriteItem[]> {
    try {
      const sql = `SELECT I.ID, I.NAME, I.VENDOR, I.RATING, I.IMAGE_PATH FROM FAV_ITEMS FI JOIN ITEMS I ON FI.ITEMS_ID = I.ID WHERE FI.USERS_USERNAME = ?`;
      const rows = await this.connection.query<SqlItems>(sql, [username]);
      if (rows.length === 0) {
        return [];
      }
      const user = await this.userRepository.get(username);
      const favItems: FavoriteItem[] = [];
      rows.forEach(async (row) => {
        const item = new Item(
          row.ID,
          row.NAME,
          row.VENDOR,
          row.RATING,
          row.IMAGE_PATH
        );
        favItems.push(new FavoriteItem(user, item));
      });
      return favItems;
    } catch (error) {
      console.error(error);
      return [];
    }
  }

  public async create(user: User, item: Item): Promise<boolean> {
    try {
      const sql = `INSERT INTO FAV_ITEMS (USERS_USERNAME, ITEMS_ID) VALUES (?, ?)`;
      const result = await this.connection.query<ResultSetHeader>(sql, [
        user.getUsername(),
        item.getId(),
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
