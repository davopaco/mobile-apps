import LoginController from "./LoginController";
import { Router } from "express";

export default class LoginRoute {
  router: Router;

  constructor(private readonly loginController: LoginController) {
    this.router = Router();
    this.routes();
  }

  public routes(): void {
    this.router.post(
      "/login",
      this.loginController.login.bind(this.loginController)
    );
  }
}
