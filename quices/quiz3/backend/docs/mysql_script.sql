CREATE DATABASE IF NOT EXISTS `USERS`;
USE `USERS`;

-- -----------------------------------------------------
-- Table `USERS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS USERS (
  `USERNAME` VARCHAR(30) NOT NULL,
  `NAME` VARCHAR(120) NOT NULL,
  `HASH` VARCHAR(64) NOT NULL,
  PRIMARY KEY (`USERNAME`));
