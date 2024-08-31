import { Router } from "express";
import LoginController from "../controller/LoginController";

export default class LoginRouter {
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
