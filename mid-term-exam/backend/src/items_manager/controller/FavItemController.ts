import CustomRequest from "../model/interfaces/CustomRequest";
import FavItemService from "../services/FavItemService";
import { Response } from "express";

export default class FavItemController {
  constructor(private readonly favItemService: FavItemService) {}

  public async getFavItems(req: CustomRequest, res: Response): Promise<void> {
    try {
      const user = req.user;
      const favItems = await this.favItemService.getAllFavItems(user.username);
      if (favItems.length === 0) {
        res.status(404).json({ message: "No favorite items found" });
        return;
      }
      res.status(200).json(favItems);
    } catch (e) {
      console.log(e);
      res
        .status(500)
        .json({ message: "There was an error with the data. Try again!" });
    }
  }

  public async addFavItem(req: CustomRequest, res: Response): Promise<void> {
    try {
      const user = req.user;
      const { item_id } = req.body;
      await this.favItemService.addFavItem(item_id, user.username);
      res.status(200).json({ message: "Item added to favorites" });
    } catch (e) {
      console.log(e);
      res
        .status(500)
        .json({ message: "There was an error with the data. Try again!" });
    }
  }

  public async removeFavItem(req: CustomRequest, res: Response): Promise<void> {
    try {
      const user = req.user;
      const { item_id } = req.body;
      await this.favItemService.removeFavItem(item_id, user.username);
      res.status(200).json({ message: "Item removed from favorites" });
    } catch (e) {
      console.log(e);
      res
        .status(500)
        .json({ message: "There was an error with the data. Try again!" });
    }
  }
}
