export default class DatabaseEnvironment {
  DB_HOST: string;
  DB_PORT: number;
  DB_USER: string;
  DB_PASSWORD: string;
  DATABASE: string;

  constructor() {
    this.DB_HOST = process.env["DB_HOST"] ?? "localhost";
    this.DB_PORT = parseInt(process.env["DB_PORT"] ?? "1802");
    this.DB_USER = process.env["DB_USER"] ?? "";
    this.DB_PASSWORD = process.env["DB_PASSWORD"] ?? "";
    this.DATABASE = process.env["DATABASE"] ?? "";
  }
}
