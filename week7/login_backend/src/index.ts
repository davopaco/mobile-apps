import EnvironmentConfig from "./EnvironmentConfig";
import Express from "./Express";
import LoginController from "./LoginController";
import LoginModel from "./LoginModel";
import LoginRoute from "./LoginRoute";

const envConfig = new EnvironmentConfig();
const loginModel = new LoginModel(envConfig);
const loginController = new LoginController(loginModel);
const loginRoute = new LoginRoute(loginController);
const backendApp = new Express(loginRoute, envConfig);

backendApp.start();
