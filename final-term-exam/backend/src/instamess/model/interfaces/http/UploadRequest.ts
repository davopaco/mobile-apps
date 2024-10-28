import { Request } from "express";

export default interface UploadRequest extends Request {
  file?: Express.Multer.File;
}
