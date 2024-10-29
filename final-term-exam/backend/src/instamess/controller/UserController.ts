import { Request, Response } from "express";
import HttpRegisterUser from "../model/interfaces/http/request/HttpRegisterUser";
import HttpLoginUser from "../model/interfaces/http/request/HttpLoginUser";
import UploadRequest from "../model/interfaces/http/request/UploadRequest";
import UserUseCase from "../usecases/UserUseCase";
import UserReturn from "../model/interfaces/http/response/UserReturn";

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

    const returnUsers: UserReturn[] = users.map((user) => {
      const base64Image = user.getPfp().toString("base64");
      const pfp = `data:${user.getImageType()};base64,${base64Image}`;

      return {
        email: user.getEmail(),
        name: user.getName(),
        phone: user.getPhone(),
        position: user.getPosition().getName(),
        pfp: pfp,
      };
    });

    res.status(200).json({ users: returnUsers });
  }

  public async getUser(req: Request, res: Response): Promise<void> {
    const emailToGet = req.query.emailToGet as string;

    if (!emailToGet) {
      res.status(400).json({ message: "Missing email" });
      return;
    }

    const user = await this.userUseCase.getUser(emailToGet);

    const base64Image = user.getPfp().toString("base64");
    const pfp = `data:${user.getImageType()};base64,${base64Image}`;

    const returnUser: UserReturn = {
      email: user.getEmail(),
      name: user.getName(),
      phone: user.getPhone(),
      position: user.getPosition().getName(),
      pfp: pfp,
    };

    res.status(200).json({ user: returnUser });
  }

  public async getAllPositions(_req: Request, res: Response): Promise<void> {
    const positions = await this.userUseCase.getAllPositions();
    res.status(200).json({ positions: positions });
  }
}
