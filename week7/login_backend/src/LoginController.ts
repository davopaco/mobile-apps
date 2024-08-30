import { Request, Response } from "express";
import LoginModel from "./LoginModel";

export default class LoginController {
  constructor(private readonly loginModel: LoginModel) {}

  public login(req: Request, res: Response): void {
    const { username, password } = req.body;

    //Checks if the username and password are correct
    const user = this.loginModel.checkPassword(username, password);

    //If the username and password are correct, a token is generated
    if (user) {
      const tokenGenerated = this.loginModel.generateJWT(username);
      res.status(200).json({ token: tokenGenerated });
      return;
    }
    res.status(401).json({ message: "Invalid username or password" });
  }
}
