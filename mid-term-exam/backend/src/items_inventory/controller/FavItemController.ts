import CustomRequest from "../model/interfaces/CustomRequest";
import FavItemService from "../services/FavItemService";
import { Response } from "express";

export default class FavItemController {
  constructor(private readonly favItemService: FavItemService) {}

  public async getFavItems(req: CustomRequest, res: Response): Promise<void> {
    const user = req.user;
    const favItems = await this.favItemService.getAllFavItems(user.username);
    if (favItems.length === 0) {
      res.status(404).json({ message: "No favorite items found" });
      return;
    }
    res.status(200).json(favItems);
  }

  public async addFavItem(req: Request, res: Response): Promise<void> {
    const user = req.user as User;
    const item = req.body as APIItem;
    await this.favItemService.addFavItem(user, item);
    res.status(200).json({ message: "Item added to favorites" });
  }

  public async removeFavItem(req: Request, res: Response): Promise<void> {
    const user = req.user as User;
    const item = req.body as APIItem;
    await this.favItemService.removeFavItem(user, item);
    res.status(200).json({ message: "Item removed from favorites" });
  }
}
