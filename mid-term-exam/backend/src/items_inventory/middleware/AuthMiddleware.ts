import CustomRequest from "../model/interfaces/CustomRequest";
import UserService from "../services/UserService";
import { Response, NextFunction } from "express";

export default class AuthMiddleware {
  constructor(private readonly userService: UserService) {}

  public async verify(
    req: CustomRequest,
    res: Response,
    next: NextFunction
  ): Promise<void> {
    const notSanToken = req.header("Authorization"); // Get the full value of the Authorization header
    if (notSanToken === undefined) {
      res.status(401).json({ message: "Token is required" });
      return;
    }

    const token = notSanToken.split(" ")[1]; // Get the token value

    const isTokenValid = await this.userService.verifyJWT(token);
    if (isTokenValid) {
      req.user = await this.userService.decodeJWT(token);
      next(); // Get the user from the token // The request is passed to the controller
    }
    res.status(401).json({ message: "Token is invalid" });
  }
}
