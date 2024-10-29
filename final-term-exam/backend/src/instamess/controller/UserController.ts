import { Request, Response } from "express";
import HttpRegisterUser from "../model/interfaces/http/HttpRegisterUser";
import HttpLoginUser from "../model/interfaces/http/HttpLoginUser";
import UploadRequest from "../model/interfaces/http/UploadRequest";
import UserUseCase from "../usecases/UserUseCase";

export default class UserController {
  constructor(private readonly userUseCase: UserUseCase) {}

  public async login(req: Request, res: Response): Promise<void> {
    const httpLoginUser = req.body as HttpLoginUser;

    const requiredFields: (keyof HttpLoginUser)[] = [
      "email",
      "password",
      "fcmToken",
    ];
    for (const field of requiredFields) {
      if (!httpLoginUser[field]) {
        res.status(400).json({ message: `Missing field: ${field}` });
        return;
      }
    }

    const login = await this.userUseCase.login(httpLoginUser);

    if (login !== "") {
      res.status(200).json({ token: login });
      return;
    }

    res.status(401).json({ message: "Invalid username or password" });
  }

  public async register(req: UploadRequest, res: Response): Promise<void> {
    const httpRegisterUser = req.body as HttpRegisterUser;

    const requiredFields: (keyof HttpRegisterUser)[] = [
      "email",
      "password",
      "name",
      "fcmToken",
      "phone",
      "positionId",
    ];

    for (const field of requiredFields) {
      if (!httpRegisterUser[field]) {
        res.status(400).json({ message: `Missing field: ${field}` });
        return;
      }
    }

    if (!req.file) {
      res.status(400).json({ message: "No file uploaded" });
      return;
    }
    httpRegisterUser.pfp = req.file;

    const register = await this.userUseCase.register(httpRegisterUser);
    if (register.exists) {
      res.status(409).json({ message: "User already exists" });
    } else if (register.jwt === "") {
      res.status(500).json({ message: "Internal server error" });
    } else {
      res.status(201).json({ token: register.jwt });
    }
  }

  public async getAllUsers(_req: Request, res: Response): Promise<void> {
    const users = await this.userUseCase.getAllUsers();
    res.status(200).json({ users: users });
  }

  public async getAllPositions(_req: Request, res: Response): Promise<void> {
    const positions = await this.userUseCase.getAllPositions();
    res.status(200).json({ positions: positions });
  }
}
