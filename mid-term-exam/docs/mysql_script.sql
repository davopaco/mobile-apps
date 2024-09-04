-- -----------------------------------------------------
-- Table `USERS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS USERS (
  `USERNAME` VARCHAR(30) NOT NULL,
  `NAME` VARCHAR(120) NOT NULL,
  `HASH` VARCHAR(64) NOT NULL,
  PRIMARY KEY (`USERNAME`));


-- -----------------------------------------------------
-- Table `ITEMS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS ITEMS (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `NAME` VARCHAR(30) NOT NULL,
  `VENDOR` VARCHAR(45) NOT NULL,
  `RATING` INT NOT NULL,
  `IMAGE_PATH` TEXT NOT NULL,
  PRIMARY KEY (`ID`));


-- -----------------------------------------------------
-- Table `FAV_ITEMS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS FAV_ITEMS (
  `USERS_USERNAME` VARCHAR(30) NOT NULL,
  `ITEMS_ID` INT NOT NULL,
  PRIMARY KEY (`USERS_USERNAME`, `ITEMS_ID`),
  INDEX `fk_FAV_ITEMS_USERS1_idx` (`USERS_USERNAME` ASC) VISIBLE,
  INDEX `fk_FAV_ITEMS_ITEMS1_idx` (`ITEMS_ID` ASC) VISIBLE,
  CONSTRAINT `fk_FAV_ITEMS_USERS1`
    FOREIGN KEY (`USERS_USERNAME`)
    REFERENCES `USERS` (`USERNAME`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_FAV_ITEMS_ITEMS1`
    FOREIGN KEY (`ITEMS_ID`)
    REFERENCES `ITEMS` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
