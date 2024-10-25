import Message from "../model/message/Message";
import SqlMessage from "../model/sql/SqlMessage";
import ARepository from "./ARepository";

export default class MessageRepository extends ARepository<
  Message,
  number,
  SqlMessage
> {}
