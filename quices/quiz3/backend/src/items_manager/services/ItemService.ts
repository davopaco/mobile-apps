import Item from "../model/item/Item";
import NItem from "../model/item/NItem";
import ItemRepository from "../repository/ItemRepository";

export default class ItemService {
  constructor(private readonly itemRepository: ItemRepository) {}

  public async getItemById(id: number): Promise<Item> {
    const allItems = await this.itemRepository.getAllItems();
    return allItems.find((item) => item.getId() === id) ?? new NItem();
  }

  public async getAllItems(): Promise<Item[]> {
    return await this.itemRepository.getAllItems();
  }

  public async getSaleItems(): Promise<Item[]> {
    const allItems = await this.itemRepository.getAllItems();
    return await this.itemRepository.getSaleItems(allItems);
  }
}
