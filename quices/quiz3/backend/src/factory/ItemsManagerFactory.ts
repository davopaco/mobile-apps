import EnvironmentConfig from "../config/EnvironmentConfig";
import ExpressRouter from "../express/interface/ExpressRouter";
import JWTManager from "../helper/JWTManager";
import ItemController from "../items_manager/controller/ItemController";
import LoginController from "../items_manager/controller/LoginController";
import AuthMiddleware from "../items_manager/middleware/AuthMiddleware";
import TokenUser from "../items_manager/model/interfaces/TokenUser";
import ItemRepository from "../items_manager/repository/ItemRepository";
import UserRepository from "../items_manager/repository/UserRepository";
import ItemRouter from "../items_manager/router/ItemRouter";
import LoginRouter from "../items_manager/router/LoginRouter";
import ItemService from "../items_manager/services/ItemService";
import UserService from "../items_manager/services/UserService";
import DatabaseEnvironment from "../config/DatabaseEnvironment";
import MySqlDBC from "../util/database/MySqlDBC";
import MySqlConnectionConfig from "../util/database/types/ConnectionInterface";

export default class ItemsManagerFactory {
  instantiate(): ExpressRouter[] {
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

    //Helper
    const jwtManager = new JWTManager<TokenUser>(environmentConfiguration);

    //Repositories
    const userRepository = new UserRepository(mySqlDbc);
    const itemRepository = new ItemRepository();

    //Services
    const userService = new UserService(userRepository, jwtManager);
    const itemService = new ItemService(itemRepository);

    //Controllers
    const loginController = new LoginController(userService);
    const itemController = new ItemController(itemService);

    //Middleware
    const authMiddleware = new AuthMiddleware(userService);

    //Routers
    const loginRoute = new LoginRouter(loginController, authMiddleware);
    const itemRoute = new ItemRouter(itemController, authMiddleware);

    return [loginRoute, itemRoute];
  }
}
