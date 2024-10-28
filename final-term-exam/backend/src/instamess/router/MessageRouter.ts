import { Router } from "express";
import ExpressRouter from "../../express/interface/ExpressRouter";
import AuthMiddleware from "../middleware/AuthMiddleware";
import MessageController from "../controller/MessageController";

export default class MessageRouter implements ExpressRouter {
  router: Router;
  path: string;

  constructor(
    private readonly messageController: MessageController,
    private readonly authMiddleware: AuthMiddleware
  ) {
    this.router = Router();
    this.path = "/message";
    this.routes();
  }

  public routes(): void {
    this.router.get(
      "/all",
      this.authMiddleware.verify.bind(this.authMiddleware),
      this.messageController.getAllMessagesForUser.bind(this.messageController)
    );

    this.router.post(
      "/send",
      this.authMiddleware.verify.bind(this.authMiddleware),
      this.messageController.sendMessage.bind(this.messageController)
    );
  }
}
