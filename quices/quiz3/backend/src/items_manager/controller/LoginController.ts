import { Request, Response } from "express";
import UserService from "../services/UserService";

export default class LoginController {
  constructor(private readonly userService: UserService) {}

  public async login(req: Request, res: Response): Promise<void> {
    const { username, password } = req.body;

    const user = await this.userService.checkPassword(username, password);

    //If the username and password are correct, a token is generated and returned
    if (user) {
      const tokenGenerated = await this.userService.generateJWT(username);
      res.status(200).json({ token: tokenGenerated });
      return;
    }
    res.status(401).json({ message: "Invalid username or password" });
  }

  public async register(req: Request, res: Response): Promise<void> {
    const { username, name, password } = req.body;

    const user = await this.userService.getUser(username);

    //If the username does not exist, it is created
    if (user.isNull()) {
      await this.userService.addUser(username, name, password);
      res.status(201).json({ message: "User created" });
      return;
    }
    res.status(400).json({ message: "Username already exists" });
  }
}
