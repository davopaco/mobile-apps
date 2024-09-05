import TokenUser from "../model/interfaces/TokenUser";
import FavItemService from "../services/FavItemService";
import { Request, Response } from "express";

export default class FavItemController {
  constructor(private readonly favItemService: FavItemService) {}

  public async getFavItems(req: Request, res: Response): Promise<void> {
    try {
      const user = req.body.user as TokenUser;
      const favItems = await this.favItemService.getAllFavItems(user.username);
      console.log(favItems);
      res.status(200).json({ favorite: favItems });
    } catch (e) {
      console.log(e);
      res
        .status(500)
        .json({ message: "There was an error with the data. Try again!" });
    }
  }

  public async addFavItem(req: Request, res: Response): Promise<void> {
    try {
      const user = req.body.user as TokenUser;
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

  public async removeFavItem(req: Request, res: Response): Promise<void> {
    try {
      const user = req.body.user as TokenUser;
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
