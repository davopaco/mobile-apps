-- -----------------------------------------------------
-- Table `POSITION`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `POSITION` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `NAME` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID`));


-- -----------------------------------------------------
-- Table `USER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `USER` (
  `EMAIL` VARCHAR(50) NOT NULL,
  `HASH` VARCHAR(64) NOT NULL,
  `PFP` TEXT NOT NULL,
  `NAME` VARCHAR(100) NOT NULL,
  `PHONE` BIGINT NOT NULL,
  `POSITION_ID` INT NOT NULL,
  PRIMARY KEY (`EMAIL`),
  INDEX `fk_USER_POSITION_idx` (`POSITION_ID` ASC) VISIBLE,
  CONSTRAINT `fk_USER_POSITION`
    FOREIGN KEY (`POSITION_ID`)
    REFERENCES `POSITION` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `DEVICE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DEVICE` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `FCM_TOKEN` TEXT NOT NULL,
  PRIMARY KEY (`ID`));


-- -----------------------------------------------------
-- Table `MESSAGE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MESSAGE` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `TITLE` VARCHAR(45) NOT NULL,
  `CONTENT` TEXT NOT NULL,
  `TIMESTAMP` TIMESTAMP NOT NULL DEFAULT NOW(),
  `USER_ORIGIN_EMAIL` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_MESSAGE_USER1_idx` (`USER_ORIGIN_EMAIL` ASC) VISIBLE,
  CONSTRAINT `fk_MESSAGE_USER1`
    FOREIGN KEY (`USER_ORIGIN_EMAIL`)
    REFERENCES `USER` (`EMAIL`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `DEVICE_has_MESSAGE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DEVICE_has_MESSAGE` (
  `DEVICE_ID` INT NOT NULL,
  `MESSAGE_ID` INT NOT NULL,
  `RESPONSE` TEXT NOT NULL,
  PRIMARY KEY (`DEVICE_ID`, `MESSAGE_ID`),
  INDEX `fk_DEVICE_has_MESSAGE_MESSAGE1_idx` (`MESSAGE_ID` ASC) VISIBLE,
  INDEX `fk_DEVICE_has_MESSAGE_DEVICE1_idx` (`DEVICE_ID` ASC) VISIBLE,
  CONSTRAINT `fk_DEVICE_has_MESSAGE_DEVICE1`
    FOREIGN KEY (`DEVICE_ID`)
    REFERENCES `DEVICE` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_DEVICE_has_MESSAGE_MESSAGE1`
    FOREIGN KEY (`MESSAGE_ID`)
    REFERENCES `MESSAGE` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `USER_has_DEVICE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `USER_has_DEVICE` (
  `USER_EMAIL` VARCHAR(50) NOT NULL,
  `DEVICE_ID` INT NOT NULL,
  `LOGGED` TINYINT NOT NULL,
  PRIMARY KEY (`USER_EMAIL`, `DEVICE_ID`),
  INDEX `fk_USER_has_DEVICE_DEVICE1_idx` (`DEVICE_ID` ASC) VISIBLE,
  INDEX `fk_USER_has_DEVICE_USER1_idx` (`USER_EMAIL` ASC) VISIBLE,
  CONSTRAINT `fk_USER_has_DEVICE_USER1`
    FOREIGN KEY (`USER_EMAIL`)
    REFERENCES `USER` (`EMAIL`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_USER_has_DEVICE_DEVICE1`
    FOREIGN KEY (`DEVICE_ID`)
    REFERENCES `DEVICE` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

