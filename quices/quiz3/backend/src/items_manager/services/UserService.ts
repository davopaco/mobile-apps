import JWTManager from "../../helper/JWTManager";
import TokenUser from "../model/interfaces/TokenUser";
import User from "../model/user/User";
import UserRepository from "../repository/UserRepository";
import bcrypt from "bcrypt";

export default class UserService {
  private salt: string;

  constructor(
    private readonly userRepository: UserRepository,
    private readonly jwtManager: JWTManager<TokenUser>
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

  public async generateJWT(
    payload: { username: string; password?: string; session: number },
    expiration: string,
    session: number
  ): Promise<string> {
    const user = await this.userRepository.get(payload.username);
    if (user.isNull()) {
      return "";
    }
    const tokenGenerated = this.jwtManager.generateToken(
      {
        username: payload.username,
        ...(payload.password ? { password: payload.password } : {}),
        name: user.getName(),
      },
      expiration,
      session
    );
    return tokenGenerated;
  }

  public async verifyJWT(token: string, session: number): Promise<boolean> {
    return this.jwtManager.verifyToken(token, session);
  }

  public async decodeJWT(token: string): Promise<TokenUser> {
    return this.jwtManager.decodeToken(token);
  }
}
