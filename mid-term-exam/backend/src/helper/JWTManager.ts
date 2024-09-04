import jwt from "jsonwebtoken";
import EnvironmentConfig from "../../config/EnvironmentConfig";

export default class JWTManager {
  private readonly expiration: string;

  constructor(
    private readonly envConfig: EnvironmentConfig,
    expiration: string
  ) {
    this.expiration = expiration;
  }

  public generateToken(payload: any): string {
    return jwt.sign(payload, this.envConfig.getJwtSecret(), {
      expiresIn: this.expiration,
    });
  }

  public verifyToken(token: string): boolean {
    try {
      jwt.verify(token, this.envConfig.getJwtSecret());
      return true;
    } catch (err) {
      return false;
    }
  }
}
