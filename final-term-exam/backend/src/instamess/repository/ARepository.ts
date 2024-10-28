import { ResultSetHeader } from "mysql2";
import MySqlDBC from "../../util/database/MySqlDBC";
import IFactory from "./factories/IFactory";

export default abstract class ARepository<Model, IdType, SqlType> {
  constructor(
    protected readonly connection: MySqlDBC,
    protected readonly modelFactory: IFactory<Model, SqlType>
  ) {}

  public async get(id: IdType): Promise<Model> {
    try {
      const sql = this.modelFactory.getQuery;
      const rows = await this.connection.query<SqlType>(sql, [id]);
      if (rows.length === 0) {
        return this.modelFactory.nullModelFactory();
      }
      const dbUser = rows[0];
      return this.modelFactory.modelFactory(dbUser);
    } catch (error) {
      console.error(error);
      return this.modelFactory.nullModelFactory();
    }
  }

  public async getAll(): Promise<Model[]> {
    try {
      const sql = this.modelFactory.getAllQuery;
      const rows = await this.connection.query<SqlType>(sql);
      if (rows.length === 0) {
        return [];
      }
      return Promise.all(
        rows.map(async (row) => await this.modelFactory.modelFactory(row))
      );
    } catch (error) {
      console.error(error);
      return [];
    }
  }

  public async create(entity: Model): Promise<boolean> {
    try {
      const sql = this.modelFactory.createQuery;
      const result = await this.connection.query<ResultSetHeader>(
        sql,
        this.modelFactory.setCreateParams(entity)
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
