import Message from "../model/message/Message";
import SqlMessage from "../model/interfaces/sql/SqlMessage";
import ARepository from "./ARepository";

export default class MessageRepository extends ARepository<
  Message,
  number,
  SqlMessage
> {
  async getMessagesByUserEmail(email: string): Promise<Message[]> {
    const sql = "SELECT * FROM MESSAGE WHERE USER_EMAIL = ?";

    const rows = await this.connection.query<SqlMessage>(sql, [email]);
    const messages = await Promise.all(
      rows.map((row) => this.modelFactory.modelFactory(row))
    );
    return messages;
  }
}
