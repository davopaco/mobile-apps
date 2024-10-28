export default interface HttpRegisterUser {
  email: string;
  password: string;
  name: string;
  pfp: Express.Multer.File;
  phone: number;
  positionId: number;
  fcmToken: string;
}
