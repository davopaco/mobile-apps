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

  public async addItems(items: Item[]): Promise<boolean> {
    let result = true;
    items.forEach(async (item) => {
      if (!(await this.itemRepository.create(item))) {
        result = false;
      }
    });
    return result;
  }
}
