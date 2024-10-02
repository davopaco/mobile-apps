import jwt from "jsonwebtoken";
import EnvironmentConfig from "../config/EnvironmentConfig";

export default class JWTManager<E extends string | object | Buffer> {
  constructor(private readonly envConfig: EnvironmentConfig) {}

  public generateToken(payload: E, expiration: string, secret: number): string {
    const jwtSecret =
      secret === 1
        ? this.envConfig.getJwtSecret()
        : this.envConfig.getJwtSecret2();

    return jwt.sign(payload, jwtSecret, {
      expiresIn: expiration,
    });
  }

  public verifyToken(token: string, secret: number): boolean {
    try {
      jwt.verify(
        token,
        secret === 1
          ? this.envConfig.getJwtSecret()
          : this.envConfig.getJwtSecret2()
      );
      return true;
    } catch (err) {
      return false;
    }
  }

  public decodeToken(token: string): E {
    return jwt.decode(token) as E;
  }
}
