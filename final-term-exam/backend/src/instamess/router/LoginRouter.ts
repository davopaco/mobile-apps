import { Router } from "express";
import LoginController from "../controller/LoginController";
import ExpressRouter from "../../express/interface/ExpressRouter";

export default class LoginRouter implements ExpressRouter {
  router: Router;
  path: string;

  constructor(private readonly loginController: LoginController) {
    this.router = Router();
    this.path = "/user";
    this.routes();
  }

  public routes(): void {
    this.router.post(
      "/login",
      this.loginController.login.bind(this.loginController)
    );

    this.router.post(
      "/register",
      this.loginController.register.bind(this.loginController)
    ); // This route is not meant for using on the application, it is only meant for user-creation purposes.
  }
}
