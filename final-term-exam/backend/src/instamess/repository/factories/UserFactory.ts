import SqlUser from "../../model/interfaces/sql/SqlUser";
import NUser from "../../model/user/NUser";
import User from "../../model/user/User";
import PositionRepository from "../PositionRepository";
import IFactory from "./IFactory";

export default class UserFactory implements IFactory<User, SqlUser> {
  public getQuery = "SELECT * FROM USER WHERE EMAIL = ?";
  public getAllQuery = "SELECT * FROM USER";
  public createQuery =
    "INSERT INTO USER (EMAIL, HASH, PFP, NAME, PHONE, IMAGE_TYPE, POSITION_ID) VALUES (?, ?, ?, ?, ?, ?, ?)";

  constructor(private readonly positionRepository: PositionRepository) {}

  async modelFactory(sqlUser: SqlUser): Promise<User> {
    return new User(
      sqlUser.EMAIL,
      sqlUser.NAME,
      sqlUser.HASH,
      await this.positionRepository.get(sqlUser.POSITION_ID),
      sqlUser.PFP,
      sqlUser.IMAGE_TYPE,
      sqlUser.PHONE
    );
  }

  nullModelFactory(): User {
    return new NUser();
  }

  setCreateParams(user: User): any[] {
    return [
      user.getEmail(),
      user.getHash(),
      user.getPfp(),
      user.getName(),
      user.getPhone(),
      user.getImageType(),
      user.getPosition().getId(),
    ];
  }
}
