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
    const tokentype = req.header("TokenType");
    let session: number;

    switch (tokentype) {
      case "login":
        session = 1;
        break;
      case "session":
        session = 2;
        break;
      default:
        res.status(400).json({ message: "Token type is invalid" });
        return;
    }

    const token = notSanToken.split(" ")[1]; // Get the token value

    const isTokenValid = await this.userService.verifyJWT(token, session); // Verify the token
    if (isTokenValid) {
      req.body.user = await this.userService.decodeJWT(token);
      next(); // Get the user from the token // The request is passed to the controller
      return;
    }
    res.status(401).json({ message: "Token is invalid" });
  }
}
