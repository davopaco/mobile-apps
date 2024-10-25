import Device from "../model/device/Device";
import SqlDevice from "../model/sql/SqlDevice";
import ARepository from "./ARepository";

export default class DeviceRepository extends ARepository<
  Device,
  number,
  SqlDevice
> {}
