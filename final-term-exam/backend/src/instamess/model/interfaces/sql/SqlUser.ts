export default interface SqlUser {
  EMAIL: string;
  HASH: string;
  PFP: Buffer;
  NAME: string;
  PHONE: number;
  POSITION_ID: number;
  IMAGE_TYPE: string;
}
