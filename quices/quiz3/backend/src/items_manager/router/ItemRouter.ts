import { Router } from "express";
import ExpressRouter from "../../express/interface/ExpressRouter";
import ItemController from "../controller/ItemController";
import AuthMiddleware from "../middleware/AuthMiddleware";

export default class ItemRouter implements ExpressRouter {
  router: Router;
  path: string;

  constructor(
    private readonly itemController: ItemController,
    private readonly authMiddleware: AuthMiddleware
  ) {
    this.router = Router();
    this.path = "/items";
    this.routes();
  }

  public routes(): void {
    this.router.get(
      "/all",
      this.authMiddleware.verify.bind(this.authMiddleware),
      this.itemController.getAllItems.bind(this.itemController)
    );

    this.router.get(
      "/sale",
      this.authMiddleware.verify.bind(this.authMiddleware),
      this.itemController.getSaleItems.bind(this.itemController)
    );

    this.router.get(
      "/:id",
      this.authMiddleware.verify.bind(this.authMiddleware),
      this.itemController.getItemById.bind(this.itemController)
    );
  }
}
