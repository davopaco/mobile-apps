export default interface IFactory<Model, SqlType> {
  getQuery: string;
  getAllQuery: string;
  createQuery: string;
  setCreateParams(entity: Model): any[];
  nullModelFactory(): Model;
  modelFactory(sql: SqlType): Promise<Model>;
}
