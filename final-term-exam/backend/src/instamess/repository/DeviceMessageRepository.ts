import DeviceMessage from "../model/deviceMessage/DeviceMessage";
import SqlDeviceMessage from "../model/interfaces/sql/SqlDeviceMessage";
import ARepository from "./ARepository";

export default class DeviceMessageRepository extends ARepository<
  DeviceMessage,
  number,
  SqlDeviceMessage
> {}
