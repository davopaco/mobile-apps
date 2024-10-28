import SqlPosition from "../../model/interfaces/sql/SqlPosition";
import NPosition from "../../model/position/NPosition";
import Position from "../../model/position/Position";
import IFactory from "./IFactory";

export default class PositionFactory
  implements IFactory<Position, SqlPosition>
{
  public getQuery: string;
  public getAllQuery: string;
  public createQuery: string;

  constructor() {
    this.getQuery = "SELECT * FROM POSITION WHERE ID = ?";
    this.getAllQuery = "SELECT * FROM POSITION";
    this.createQuery = "INSERT INTO POSITION (NAME) VALUES (?)";
  }

  async modelFactory(sqlPosition: SqlPosition): Promise<Position> {
    return new Position(sqlPosition.ID, sqlPosition.NAME);
  }

  nullModelFactory() {
    return new NPosition();
  }

  setCreateParams(position: Position): any[] {
    return [position.getName()];
  }
}
