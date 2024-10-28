import EnvironmentConfig from "../config/EnvironmentConfig";
import ExpressRouter from "../express/interface/ExpressRouter";
import JWTManager from "../helper/JWTManager";
import DatabaseEnvironment from "../config/DatabaseEnvironment";
import MySqlDBC from "../util/database/MySqlDBC";
import MySqlConnectionConfig from "../util/database/types/ConnectionInterface";
import TokenUser from "../instamess/model/interfaces/TokenUser";
import AuthMiddleware from "../instamess/middleware/AuthMiddleware";
import UserController from "../instamess/controller/UserController";
import PositionRepository from "../instamess/repository/PositionRepository";
import PositionFactory from "../instamess/repository/factories/PositionFactory";
import UserFactory from "../instamess/repository/factories/UserFactory";
import DeviceFactory from "../instamess/repository/factories/DeviceFactory";
import DeviceRepository from "../instamess/repository/DeviceRepository";
import MessageFactory from "../instamess/repository/factories/MessageFactory";
import MessageRepository from "../instamess/repository/MessageRepository";
import DeviceMessageFactory from "../instamess/repository/factories/DeviceMessageFactory";
import DeviceMessageRepository from "../instamess/repository/DeviceMessageRepository";
import UserDeviceFactory from "../instamess/repository/factories/UserDeviceFactory";
import UserDeviceRepository from "../instamess/repository/UserDeviceRepository";
import UserService from "../instamess/services/UserService";
import MessageService from "../instamess/services/MessageService";
import Firebase from "../util/firebase/Firebase";
import MessageController from "../instamess/controller/MessageController";
import UserRouter from "../instamess/router/UserRouter";
import MessageRouter from "../instamess/router/MessageRouter";
import UserRepository from "../instamess/repository/UserRepository";
import Multer from "../instamess/middleware/Multer";

export default class InstamessFactory {
  createRouters(): ExpressRouter[] {
    //Environment
    const environmentConfiguration = new EnvironmentConfig();
    const databaseEnvironment = new DatabaseEnvironment();

    //Database
    const mySqlConnectionConfig: MySqlConnectionConfig = {
      host: databaseEnvironment.DB_HOST,
      user: databaseEnvironment.DB_USER,
      password: databaseEnvironment.DB_PASSWORD,
      database: databaseEnvironment.DATABASE,
      port: databaseEnvironment.DB_PORT,
    };
    const mySqlDbc = new MySqlDBC(mySqlConnectionConfig);

    //Firebase
    const firebase = Firebase.getInstance();

    //Helper
    const jwtManager = new JWTManager<TokenUser>(
      environmentConfiguration,
      "7d"
    );

    //Repositories and Factories
    const postitionFactory = new PositionFactory();
    const positionRepository = new PositionRepository(
      mySqlDbc,
      postitionFactory
    );

    const userFactory = new UserFactory(positionRepository);
    const userRepository = new UserRepository(mySqlDbc, userFactory);

    const deviceFactory = new DeviceFactory();
    const deviceRepository = new DeviceRepository(mySqlDbc, deviceFactory);

    const messageFactory = new MessageFactory(userRepository);
    const messageRepository = new MessageRepository(mySqlDbc, messageFactory);

    const deviceMessageFactory = new DeviceMessageFactory(
      deviceRepository,
      messageRepository
    );
    const deviceMessageRepository = new DeviceMessageRepository(
      mySqlDbc,
      deviceMessageFactory
    );

    const userDeviceFactory = new UserDeviceFactory(
      userRepository,
      deviceRepository
    );
    const userDeviceRepository = new UserDeviceRepository(
      mySqlDbc,
      userDeviceFactory
    );

    //Services
    const userService = new UserService(
      userRepository,
      positionRepository,
      jwtManager
    );
    const messageService = new MessageService(
      deviceMessageRepository,
      firebase,
      userDeviceRepository,
      userRepository
    );

    //Controllers
    const userController = new UserController(userService);
    const messageController = new MessageController(messageService);

    //Middleware
    const authMiddleware = new AuthMiddleware(userService);
    const multerMiddleware = new Multer();

    //Routers
    const userRouter = new UserRouter(
      userController,
      authMiddleware,
      multerMiddleware
    );
    const messageRouter = new MessageRouter(messageController, authMiddleware);

    return [userRouter, messageRouter];
  }
}
