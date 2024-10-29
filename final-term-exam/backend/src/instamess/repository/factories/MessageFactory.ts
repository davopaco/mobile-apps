import SqlMessage from "../../model/interfaces/sql/SqlMessage";
import Message from "../../model/message/Message";
import NMessage from "../../model/message/NMessage";
import UserRepository from "../UserRepository";
import IFactory from "./IFactory";

export default class MessageFactory implements IFactory<Message, SqlMessage> {
  public getQuery = "SELECT * FROM MESSAGE WHERE ID = ?";
  public getAllQuery = "SELECT * FROM MESSAGE";
  public createQuery =
    "INSERT INTO MESSAGE (TITLE, CONTENT, TIMESTAMP, USER_ORIGIN_EMAIL) VALUES (?, ?, ?, ?)";

  constructor(private readonly userRepository: UserRepository) {}

  async modelFactory(sqlMessage: SqlMessage): Promise<Message> {
    const time = sqlMessage.TIMESTAMP.toString().split("T")[1];
    const date = new Date(sqlMessage.TIMESTAMP.toString().split("T")[0]);

    return new Message(
      sqlMessage.ID,
      sqlMessage.TITLE,
      sqlMessage.CONTENT,
      time,
      date,
      await this.userRepository.get(sqlMessage.USER_ORIGIN_EMAIL)
    );
  }

  nullModelFactory(): Message {
    return new NMessage();
  }

  setCreateParams(message: Message): any[] {
    const time = message.getTime();
    const date = message.getDate().toISOString().split("T")[0];
    const timestamp = new Date(`${date}T${time}`);

    return [
      message.getTitle(),
      message.getContent(),
      timestamp,
      message.getSenderUser().getEmail(),
    ];
  }
}
