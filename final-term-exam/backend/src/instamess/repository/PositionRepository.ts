import Position from "../model/position/Position";
import SqlPosition from "../model/sql/SqlPosition";
import ARepository from "./ARepository";

export default class PositionRepository extends ARepository<
  Position,
  number,
  SqlPosition
> {}
