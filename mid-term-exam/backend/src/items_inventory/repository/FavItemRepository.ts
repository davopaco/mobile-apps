import { ResultSetHeader } from "mysql2";
import MySqlDBC from "../../util/database/MySqlDBC";
import FavoriteItem from "../domain/model/fav_item/FavoriteItem";
import SqlFavItems from "../domain/model/sql/SqlFavItems";
import Item from "../domain/model/item/Item";
import UserRepository from "./UserRepository";
import ItemRepository from "./ItemRepository";

export default class FavItemRepository {
  constructor(
    private readonly connection: MySqlDBC,
    private readonly userRepository: UserRepository,
    private readonly itemRepository: ItemRepository
  ) {}

  public async getForUser(username: string): Promise<FavoriteItem[]> {
    try {
      const sql = `SELECT * FROM FAV_ITEMS WHERE USERS_USERNAME = ?`;
      const rows = await this.connection.query<SqlFavItems>(sql, [username]);
      if (rows.length === 0) {
        return [];
      }
      const user = await this.userRepository.get(username);
      const favItems: FavoriteItem[] = [];
      rows.forEach(async (row) => {
        const item = await this.itemRepository.get(row.ITEMS_ID);
        favItems.push(new FavoriteItem(user, item));
      });
      return favItems;
    } catch (error) {
      console.error(error);
      return [];
    }
  }

  //   public async create(user: User, item: Item): Promise<boolean> {
  //     try {
  //       const sql = `INSERT INTO USERS (USERNAME, NAME, HASH) VALUES (?, ?, ?)`;
  //       const result = await this.connection.query<ResultSetHeader>(sql, [
  //         user.getUsername(),
  //         user.getName(),
  //         user.getHash(),
  //       ]);

  //       if (result[0].affectedRows !== 1) {
  //         return false;
  //       }
  //       return true;
  //     } catch (error) {
  //       console.error(error);
  //       return false;
  //     }
  //   }
}
