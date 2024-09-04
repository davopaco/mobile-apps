import { Request } from "express";
import TokenUser from "./TokenUser";

export default interface CustomRequest extends Request {
  user: TokenUser;
}
