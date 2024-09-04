import User from "../model/user/User";
import JWTManager from "../helper/JWTManager";
import UserRepository from "../repository/UserRepository";
import bcrypt from "bcrypt";

export default class UserService {
  private salt: string;

  constructor(
    private readonly userRepository: UserRepository,
    private readonly jwtManager: JWTManager
  ) {
    this.salt = bcrypt.genSaltSync(10);
  }

  public async getUser(username: string): Promise<User> {
    return await this.userRepository.get(username);
  }

  public async addUser(
    username: string,
    name: string,
    password: string
  ): Promise<void> {
    const hash = bcrypt.hashSync(password, this.salt);
    const user = new User(username, name, hash);
    await this.userRepository.create(user);
  }

  public async checkPassword(
    username: string,
    password: string
  ): Promise<boolean> {
    const user = await this.userRepository.get(username);
    if (!user.isNull()) {
      return bcrypt.compareSync(password, user.getHash());
    }
    return false;
  }

  public async generateJWT(username: string): Promise<string> {
    const user = await this.userRepository.get(username);
    if (user.isNull()) {
      return "";
    }
    const tokenGenerated = this.jwtManager.generateToken({
      username: username,
      name: user.getName(),
    });
    return tokenGenerated;
  }

  public async verifyJWT(token: string): Promise<boolean> {
    return this.jwtManager.verifyToken(token);
  }
}
