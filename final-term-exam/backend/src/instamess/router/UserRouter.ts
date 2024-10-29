import { Router } from "express";
import UserController from "../controller/UserController";
import ExpressRouter from "../../express/interface/ExpressRouter";
import AuthMiddleware from "../middleware/AuthMiddleware";
import Multer from "../middleware/Multer";

export default class UserRouter implements ExpressRouter {
  router: Router;
  path: string;

  constructor(
    private readonly userController: UserController,
    private readonly authMiddleware: AuthMiddleware,
    private readonly multerMiddleware: Multer
  ) {
    this.router = Router();
    this.path = "/user";
    this.routes();
  }

  public routes(): void {
    this.router.post(
      "/login",
      this.userController.login.bind(this.userController)
    );

    this.router.post(
      "/register",
      this.multerMiddleware.getUpload().single("pfp"),
      this.userController.register.bind(this.userController)
    );

    this.router.get(
      "/",
      this.authMiddleware.verify.bind(this.authMiddleware),
      this.userController.getUser.bind(this.userController)
    );

    this.router.get(
      "/all",
      this.authMiddleware.verify.bind(this.authMiddleware),
      this.userController.getAllUsers.bind(this.userController)
    );

    this.router.get(
      "/position/all",
      this.userController.getAllPositions.bind(this.userController)
    );
  }
}
