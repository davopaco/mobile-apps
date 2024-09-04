import { Router } from "express";
import LoginController from "../controller/LoginController";
import ExpressRouter from "../interface/ExpressRouter";

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
  }
}
