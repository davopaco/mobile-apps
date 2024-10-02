export default class EnvironmentConfig {
  private readonly jwtSecret: string;
  private readonly jwtSecret2: string;
  private readonly PORT: number;

  constructor() {
    this.jwtSecret = process.env.JWT_SECRET ?? "secret";
    this.jwtSecret2 = process.env.JWT_SECRET2 ?? "secret";
    this.PORT = parseInt(process.env.PORT ?? "3000");
  }

  public getJwtSecret(): string {
    return this.jwtSecret;
  }

  public getJwtSecret2(): string {
    return this.jwtSecret2;
  }

  public getPORT(): number {
    return this.PORT;
  }
}
