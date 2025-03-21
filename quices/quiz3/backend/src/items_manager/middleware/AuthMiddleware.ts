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
    const payload = await this.userService.decodeJWT(token);

    const isTokenValid = await this.userService.verifyJWT(
      token,
      payload.session
    ); // Verify the token
    if (isTokenValid) {
      req.body.user = payload; // Add the user to the request
      next(); // Get the user from the token // The request is passed to the controller
      return;
    }
    res.status(401).json({ message: "Token is invalid" });
  }

  public async verifySession(
    req: Request,
    res: Response,
    next: NextFunction
  ): Promise<void> {
    const notSanToken = req.header("Authorization"); // Get the full value of the Authorization header
    if (notSanToken === undefined) {
      next();
      return;
    }

    const token = notSanToken.split(" ")[1]; // Get the token value
    const payload = await this.userService.decodeJWT(token);

    const isTokenValid = await this.userService.verifyJWT(
      token,
      payload.session
    ); // Verify the token

    if (isTokenValid) {
      req.body.username = payload.username;
      req.body.password = payload.password;
      next(); // Get the user from the token // The request is passed to the controller
      return;
    }
    res.status(401).json({ message: "Token is invalid" });
  }
}
