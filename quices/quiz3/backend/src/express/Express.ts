import express, { Application } from "express";
import EnvironmentConfig from "../config/EnvironmentConfig";
import ExpressRouter from "./interface/ExpressRouter";
import path from "path";

export default class Express {
  private readonly app: Application;

  constructor(
    private readonly expressRouter: ExpressRouter[],
    private readonly env: EnvironmentConfig
  ) {
    this.app = express();
    this.config();
    this.routes();
  }

  public getApp = (): Application => {
    return this.app;
  };

  private readonly config = (): void => {
    this.app.use(express.json());
    this.app.use(express.urlencoded({ extended: true }));
  };

  private readonly routes = (): void => {
    this.expressRouter.forEach((router) => {
      this.app.use(router.path, router.router);
    });

    this.app.use(
      "/images",
      express.static(path.join(__dirname, "..", "..", "public", "images"))
    ); // This is the endpoint to access the images

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
