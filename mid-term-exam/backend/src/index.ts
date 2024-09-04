import EnvironmentConfig from "./config/EnvironmentConfig";
import LoginController from "./express/controller/LoginController";
import Express from "./express/Express";
import LoginRouter from "./express/router/LoginRouter";
import LoginModel from "./model/LoginModel";

const envConfig = new EnvironmentConfig();
const loginModel = new LoginModel(envConfig);
const loginController = new LoginController(loginModel);
const loginRoute = new LoginRouter(loginController);
const backendApp = new Express(loginRoute, envConfig);

backendApp.start();
