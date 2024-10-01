import ItemService from "../services/ItemService";
import { Request, Response } from "express";

export default class ItemController {
  constructor(private readonly itemService: ItemService) {}

  public async getAllItems(_req: Request, res: Response): Promise<any> {
    const items = await this.itemService.getAllItems();
    if (items.length === 0) {
      res.status(404).json({ message: "Items not found!" });
      return;
    }
    res.status(200).json({ items: items });
  }

  public async getItemById(req: Request, res: Response): Promise<any> {
    const id = parseInt(req.params.id);
    const item = await this.itemService.getItemById(id);
    if (item === null) {
      res.status(404).json({ message: "Item not found!" });
      return;
    }
    res.status(200).json({ item: item });
  }

  public async getSaleItems(_req: Request, res: Response): Promise<any> {
    const items = await this.itemService.getSaleItems();
    if (items.length === 0) {
      res.status(404).json({ message: "Items not found!" });
      return;
    }
    res.status(200).json({ items: items });
  }
}
