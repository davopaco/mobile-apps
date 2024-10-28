import { Request, Response } from "express";
import HttpUserMessage from "../model/interfaces/http/HttpUserMessage";
import MessageUseCase from "../usecases/MessageUseCase";

export default class MessageController {
  constructor(private readonly messageUseCase: MessageUseCase) {}

  public async getAllMessagesForUser(
    req: Request,
    res: Response
  ): Promise<any> {
    const email = req.params.email;

    try {
      const messages = await this.messageUseCase.getAllMessagesForUser(email);
      res.status(200).json({ messages });
    } catch (e) {
      console.log(e);
      res
        .status(500)
        .json({ message: "There was an error with the data. Try again!" });
    }
  }

  public async sendMessage(req: Request, res: Response): Promise<any> {
    try {
      const message = req.body as HttpUserMessage;
      const errorMessage = await this.messageUseCase.sendMessage(message);
      if (errorMessage.error) {
        res.status(400).json({ message: errorMessage.message });
      } else {
        res.status(200).json({ message: "Message sent successfully!" });
      }
    } catch (e) {
      console.log(e);
      res
        .status(500)
        .json({
          message: "There was an error while sending the message. Try again!",
        });
    }
  }
}