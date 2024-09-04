import APIItem from "../model/interfaces/APIItem";
import ItemService from "../services/ItemService";
import { Request, Response } from "express";

export default class ItemController {
  constructor(private readonly itemService: ItemService) {}

  public async getAllItems(_req: Request, res: Response): Promise<any> {
    const items = await this.itemService.getAllItems();
    res.status(200).json({ items: items });
  }

  public async addItems(req: Request, res: Response): Promise<any> {
    const apiItems = req.body as APIItem[];
    const result = await this.itemService.addItems(apiItems);
    if (!result) {
      res.status(500).json({ message: "Error creating item/s" });
      return;
    }
    res.status(201).json({ message: "Item/s created on the database" });
  }
}
