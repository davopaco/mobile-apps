import APIItem from "../model/interfaces/APIItem";
import Item from "../model/item/Item";
import ItemRepository from "../repository/ItemRepository";

export default class ItemService {
  constructor(private readonly itemRepository: ItemRepository) {}

  public async getAllItems(): Promise<Item[]> {
    return await this.itemRepository.getAll();
  }

  public async getItem(id: number): Promise<Item> {
    return await this.itemRepository.get(id);
  }

  public async addItems(apiItems: APIItem[]): Promise<boolean> {
    let result = true;
    apiItems.forEach(async (apiItem) => {
      const item = new Item(
        apiItem.id,
        apiItem.name,
        apiItem.vendor,
        apiItem.rating,
        apiItem.imagePath
      );
      if (!(await this.itemRepository.create(item))) {
        result = false;
      }
    });
    return result;
  }
}
