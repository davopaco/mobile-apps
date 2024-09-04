import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import EnvironmentConfig from "../config/EnvironmentConfig";

export default class LoginModel {
  private users: { username: string; password: string }[];
  private salt: string;

  constructor(private readonly envConfig: EnvironmentConfig) {
    this.users = [
      { username: "ali", password: "alipwd_123" },
      { username: "admin", password: "admin_123" },
    ];
    this.salt = bcrypt.genSaltSync(10);
    this.initializeUsers();
  }

  //Hashes the passwords in the array for the already manually generated users.
  private initializeUsers(): void {
    this.users.forEach((user) => {
      user.password = bcrypt.hashSync(user.password, this.salt);
    });
  }

  //Checks if the username and password are correct
  public checkPassword(username: string, password: string): boolean {
    const user = this.users.find(
      (user) =>
        user.username === username &&
        user.password === bcrypt.hashSync(password, this.salt)
    );
    if (user) {
      return true;
    }
    return false;
  }

  //Generates a JWT for the user
  public generateJWT(username: string): string {
    const tokenGenerated = jwt.sign(
      { user: username },
      this.envConfig.getJwtSecret(),
      {
        expiresIn: "1h",
      }
    );
    return tokenGenerated;
  }
}
