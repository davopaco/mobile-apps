import APIItem from "../model/interfaces/APIItem";
import ItemService from "../services/ItemService";
import { Request, Response } from "express";

export default class ItemController {
  constructor(private readonly itemService: ItemService) {}

  public async getAllItems(_req: Request, res: Response): Promise<any> {
    const items = await this.itemService.getAllItems();
    if (!items) {
      res.status(404).json({ message: "Items not found!" });
      return;
    }
    res.status(200).json({ items: items });
  }

  public async addItems(req: Request, res: Response): Promise<any> {
    try {
      const apiItems = req.body as APIItem[];
      const result = await this.itemService.addItems(apiItems);
      if (!result) {
        res.status(500).json({ message: "Error creating item/s" });
        return;
      }
      res.status(201).json({ message: "Item/s created on the database" });
    } catch (e) {
      console.log(e);
      res
        .status(500)
        .json({ message: "There was an error with the data. Try again!" });
    }
  }
}
