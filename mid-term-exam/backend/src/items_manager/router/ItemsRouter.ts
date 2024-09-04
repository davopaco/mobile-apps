import { Router } from "express";
import ExpressRouter from "../../express/interface/ExpressRouter";
import ItemController from "../controller/ItemController";

export default class LoginRouter implements ExpressRouter {
  router: Router;
  path: string;

  constructor(private readonly itemController: ItemController) {
    this.router = Router();
    this.path = "/item";
    this.routes();
  }

  public routes(): void {
    this.router.get(
      "/all",
      this.itemController.getAllItems.bind(this.itemController)
    );

    this.router.post(
      "/add",
      this.itemController.addItems.bind(this.itemController)
    ); // This route is not meant for using on the application, only meant for items-creation purposes.
  }
}
