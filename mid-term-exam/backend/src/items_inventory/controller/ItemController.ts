import ItemService from "../services/ItemService";
import { Request, Response } from "express";

export default class ItemController {
  constructor(private readonly itemService: ItemService) {}

  public async getAllItems(req: Request, res: Response): Promise<any> {
    const items = await this.itemService.getAllItems();
    res.status(200).json({ items: items });
  }

  public async createItems(req: Request, res: Response): Promise<any> {
    const { name, vendor, rating, image_path } = req.body;
    await this.itemService.addItems(name);
    res.status(201).json({ message: "Item created" });
  }
}
