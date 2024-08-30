export default class EnvironmentConfig {
  private readonly jwtSecret: string;
  private readonly PORT: number;

  constructor() {
    this.jwtSecret = process.env.JWT_SECRET ?? "secret";
    this.PORT = parseInt(process.env.PORT ?? "3000");
  }

  public getJwtSecret(): string {
    return this.jwtSecret;
  }

  public getPORT(): number {
    return this.PORT;
  }
}
