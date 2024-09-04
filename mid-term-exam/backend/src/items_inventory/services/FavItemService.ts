import FavoriteItem from "../model/fav_item/FavoriteItem";
import FavItemRepository from "../repository/FavItemRepository";
import ItemService from "./ItemService";
import UserService from "./UserService";

export default class FavItemService {
  constructor(
    private readonly favItemRepository: FavItemRepository,
    private readonly itemService: ItemService,
    private readonly userService: UserService
  ) {}

  public async getAllFavItems(username: string): Promise<FavoriteItem[]> {
    return await this.favItemRepository.getForUser(username);
  }

  public async addFavItem(item_id: number, username: string): Promise<boolean> {
    const user = await this.userService.getUser(username);
    const item = await this.itemService.getItem(item_id);
    return await this.favItemRepository.create(user, item);
  }

  public async removeFavItem(
    item_id: number,
    username: string
  ): Promise<boolean> {
    const user = await this.userService.getUser(username);
    const item = await this.itemService.getItem(item_id);
    return await this.favItemRepository.delete(user, item);
  }
}
