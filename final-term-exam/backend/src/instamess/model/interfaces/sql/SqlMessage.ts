export default interface SqlMessage {
  ID: number;
  TITLE: string;
  CONTENT: string;
  TIMESTAMP: Date;
  USER_ORIGIN_EMAIL: string;
  USER_EMAIL: string;
}
