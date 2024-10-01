import EnvironmentConfig from "./config/EnvironmentConfig";
import Express from "./express/Express";
import ItemsManagerFactory from "./factory/ItemsManagerFactory";

const factory = new ItemsManagerFactory();
const envConfig = new EnvironmentConfig();
const backendApp = new Express(factory.instantiate(), envConfig);

backendApp.start();
