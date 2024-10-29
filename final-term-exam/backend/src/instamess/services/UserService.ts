import JWTManager from "../../helper/JWTManager";
import HttpLoginUser from "../model/interfaces/http/HttpLoginUser";
import HttpRegisterUser from "../model/interfaces/http/HttpRegisterUser";
import TokenUser from "../model/interfaces/TokenUser";
import User from "../model/user/User";
import PositionRepository from "../repository/PositionRepository";
import UserRepository from "../repository/UserRepository";
import bcrypt from "bcrypt";

export default class UserService {
  private readonly salt: string;

  constructor(
    private readonly userRepository: UserRepository,
    private readonly positionRepository: PositionRepository,
    private readonly jwtManager: JWTManager<TokenUser>
  ) {
    this.salt = bcrypt.genSaltSync(10);
  }

  public async getUser(email: string): Promise<User> {
    return await this.userRepository.get(email);
  }

  public async getAllUsers(): Promise<User[]> {
    return await this.userRepository.getAll();
  }

  public async addUser(httpRegisterUser: HttpRegisterUser): Promise<boolean> {
    const hash = bcrypt.hashSync(httpRegisterUser.password, this.salt);
    console.log(hash);
    const position = await this.positionRepository.get(
      httpRegisterUser.positionId
    );

    const user = new User(
      httpRegisterUser.email,
      httpRegisterUser.name,
      hash,
      position,
      httpRegisterUser.pfp.buffer,
      httpRegisterUser.pfp.mimetype,
      httpRegisterUser.phone
    );
    return await this.userRepository.create(user);
  }

  public async checkPassword(httpLoginUser: HttpLoginUser): Promise<boolean> {
    const user = await this.userRepository.get(httpLoginUser.email);
    if (!user.isNull()) {
      return bcrypt.compareSync(httpLoginUser.password, user.getHash());
    }
    return false;
  }

  public async generateJWT(email: string): Promise<string> {
    const user = await this.userRepository.get(email);
    if (user.isNull()) {
      return "";
    }
    const tokenGenerated = this.jwtManager.generateToken({
      email: email,
      name: user.getName(),
    });
    return tokenGenerated;
  }

  public async verifyJWT(token: string): Promise<boolean> {
    return this.jwtManager.verifyToken(token);
  }

  public async decodeJWT(token: string): Promise<TokenUser> {
    return this.jwtManager.decodeToken(token);
  }
}
