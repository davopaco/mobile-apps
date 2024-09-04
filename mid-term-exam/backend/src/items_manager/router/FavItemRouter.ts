import { Router } from "express";
import ExpressRouter from "../../express/interface/ExpressRouter";
import FavItemController from "../controller/FavItemController";
import AuthMiddleware from "../middleware/AuthMiddleware";

export default class FavItemRouter implements ExpressRouter {
  router: Router;
  path: string;

  constructor(
    private readonly favItemController: FavItemController,
    private readonly authMiddleware: AuthMiddleware
  ) {
    this.router = Router();
    this.path = "/favorite";
    this.routes();
  }

  public routes(): void {
    this.router.get(
      "/all",
      this.authMiddleware.verify,
      this.favItemController.getFavItems.bind(this.favItemController)
    );
  }
}
