import UserService from "../services/UserService";
import { Request, Response, NextFunction } from "express";

export default class AuthMiddleware {
  constructor(private readonly userService: UserService) {}

  public async verify(
    req: Request,
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
      next(); // The request is passed to the controller
    }
    res.status(401).json({ message: "Token is invalid" });
  }
}
