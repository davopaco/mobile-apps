import EnvironmentConfig from "./config/EnvironmentConfig";
import LoginController from "./items_inventory/controller/LoginController";
import Express from "./express/Express";
import LoginRouter from "./login/router/LoginRouter";
import LoginModel from "./login/model/LoginModel";

const envConfig = new EnvironmentConfig();
const loginModel = new LoginModel(envConfig);
const loginController = new LoginController(loginModel);
const loginRoute = new LoginRouter(loginController);
const backendApp = new Express([loginRoute], envConfig);

backendApp.start();
