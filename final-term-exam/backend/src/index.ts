import EnvironmentConfig from "./config/EnvironmentConfig";
import Express from "./express/Express";
import InstamessFactory from "./factory/InstamessFactory";

const factory = new InstamessFactory();
const envConfig = new EnvironmentConfig();
const backendApp = new Express(factory.instantiate(), envConfig);

backendApp.start();
