import express, { Application } from "express";
import EnvironmentConfig from "../config/EnvironmentConfig";
import LoginRouter from "./router/LoginRouter";

export default class Express {
  private readonly app: Application;

  constructor(
    private readonly expressRouter: LoginRouter,
    private readonly env: EnvironmentConfig
  ) {
    this.app = express();
    this.config();
    this.routes();
  }

  public getApp = (): Application => {
    return this.app;
  };

  private config = (): void => {
    this.app.use(express.json());
    this.app.use(express.urlencoded({ extended: true }));
  };

  private routes = (): void => {
    this.app.use(this.expressRouter.router);

    this.app.use((_req, res) => {
      res.status(404).send("404 Not Found");
    });
  };

  start = (): void => {
    this.app.listen(this.env.getPORT(), "0.0.0.0", () => {
      console.log(`Server is running on ${this.env.getPORT()}`);
    });
  };
}
