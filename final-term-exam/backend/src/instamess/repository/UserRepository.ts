import SqlUser from "../model/sql/SqlUser";
import User from "../model/user/User";
import ARepository from "./ARepository";

export default class UserRepository extends ARepository<
  User,
  string,
  SqlUser
> {}
