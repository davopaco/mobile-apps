import { ResultSetHeader } from "mysql2";
import MySqlDBC from "../../util/database/MySqlDBC";

export default abstract class ARepository<Model, IdType, SqlType> {
  constructor(
    protected readonly connection: MySqlDBC,
    protected getQuery: string,
    protected getAllQuery: string,
    protected createQuery: string,
    protected createParams: (entity: Model) => any[],
    protected readonly nullModelFactory: () => Model,
    protected readonly modelFactory: (sql: SqlType) => Model
  ) {}

  public async get(id: IdType): Promise<Model> {
    try {
      const sql = this.getQuery;
      const rows = await this.connection.query<SqlType>(sql, [id]);
      if (rows.length === 0) {
        return this.nullModelFactory();
      }
      const dbUser = rows[0];
      return this.modelFactory(dbUser);
    } catch (error) {
      console.error(error);
      return this.nullModelFactory();
    }
  }

  public async getAll(): Promise<Model[]> {
    try {
      const sql = this.getAllQuery;
      const rows = await this.connection.query<SqlType>(sql);
      if (rows.length === 0) {
        return [];
      }
      return rows.map((row) => this.modelFactory(row));
    } catch (error) {
      console.error(error);
      return [];
    }
  }

  public async create(entity: Model): Promise<boolean> {
    try {
      const sql = this.createQuery;
      const result = await this.connection.query<ResultSetHeader>(
        sql,
        this.createParams(entity)
      );

      if (result[0].affectedRows > 0) {
        return true;
      }
      return false;
    } catch (error) {
      console.error(error);
      return false;
    }
  }
}
