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
    this.path = "/item";
    this.routes();
  }

  public routes(): void {
    this.router.get(
      "/all",
      this.authMiddleware.verify,
      this.itemController.getAllItems.bind(this.itemController)
    );

    this.router.post(
      "/add",
      this.itemController.addItems.bind(this.itemController)
    ); // This route is not meant for using on the application, only meant for items-creation purposes.
  }
}
