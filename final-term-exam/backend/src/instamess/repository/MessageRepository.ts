import Message from "../model/message/Message";
import SqlMessage from "../model/interfaces/sql/SqlMessage";
import ARepository from "./ARepository";

export default class MessageRepository extends ARepository<
  Message,
  number,
  SqlMessage
> {}
