-- MySQL Script generated by MySQL Workbench
-- Wed Feb 26 23:27:43 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema trackingapp
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `trackingapp` ;

-- -----------------------------------------------------
-- Schema trackingapp
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `trackingapp` DEFAULT CHARACTER SET latin1 ;
USE `trackingapp` ;

-- -----------------------------------------------------
-- Table `trackingapp`.`status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `trackingapp`.`status` (
  `statusID` INT(11) NOT NULL AUTO_INCREMENT,
  `statusName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`statusID`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `trackingapp`.`scope`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `trackingapp`.`scope` (
  `scopeID` INT(11) NOT NULL AUTO_INCREMENT,
  `scopeName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`scopeID`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `trackingapp`.`brand`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `trackingapp`.`brand` (
  `brandID` INT(11) NOT NULL AUTO_INCREMENT,
  `brandName` VARCHAR(45) NOT NULL,
  `scopeID` INT(11) NOT NULL,
  PRIMARY KEY (`brandID`),
  INDEX `fk_brand_scope1_idx` (`scopeID` ASC),
  CONSTRAINT `fk_brand_scope1`
    FOREIGN KEY (`scopeID`)
    REFERENCES `trackingapp`.`scope` (`scopeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `trackingapp`.`locationtype`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `trackingapp`.`locationtype` (
  `locationTypeID` INT(11) NOT NULL AUTO_INCREMENT,
  `locationTypeName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`locationTypeID`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `trackingapp`.`state`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `trackingapp`.`state` (
  `stateID` INT(11) NOT NULL AUTO_INCREMENT,
  `stateName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`stateID`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `trackingapp`.`location`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `trackingapp`.`location` (
  `locationID` INT(11) NOT NULL AUTO_INCREMENT,
  `locationName` VARCHAR(45) NOT NULL,
  `stateID` INT(11) NOT NULL,
  `locationTypeID` INT(11) NOT NULL,
  PRIMARY KEY (`locationID`),
  INDEX `fk_location_state1_idx` (`stateID` ASC),
  INDEX `fk_location_locationType1_idx` (`locationTypeID` ASC),
  CONSTRAINT `fk_location_locationType1`
    FOREIGN KEY (`locationTypeID`)
    REFERENCES `trackingapp`.`locationtype` (`locationTypeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_location_state1`
    FOREIGN KEY (`stateID`)
    REFERENCES `trackingapp`.`state` (`stateID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `trackingapp`.`model`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `trackingapp`.`model` (
  `modelID` INT(11) NOT NULL AUTO_INCREMENT,
  `modelName` VARCHAR(45) NOT NULL,
  `scopeID` INT(11) NOT NULL,
  PRIMARY KEY (`modelID`),
  UNIQUE INDEX `modelName_UNIQUE` (`modelName` ASC),
  INDEX `fk_model_scope1_idx` (`scopeID` ASC),
  CONSTRAINT `fk_model_scope1`
    FOREIGN KEY (`scopeID`)
    REFERENCES `trackingapp`.`scope` (`scopeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `trackingapp`.`serial`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `trackingapp`.`serial` (
  `serialID` INT(11) NOT NULL AUTO_INCREMENT,
  `serialName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`serialID`),
  UNIQUE INDEX `serialName_UNIQUE` (`serialName` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 8
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `trackingapp`.`asset`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `trackingapp`.`asset` (
  `assetID` INT(11) NOT NULL AUTO_INCREMENT,
  `brandID` INT(11) NOT NULL,
  `modelID` INT(11) NOT NULL,
  `serialID` INT(11) NOT NULL,
  `locationID` INT(11) NOT NULL,
  `statusID` INT(11) NOT NULL,
  PRIMARY KEY (`assetID`),
  INDEX `fk_asset_brand1_idx` (`brandID` ASC),
  INDEX `fk_asset_model1_idx` (`modelID` ASC),
  INDEX `fk_asset_location1_idx` (`locationID` ASC),
  INDEX `fk_asset_assetStatus1_idx` (`statusID` ASC),
  INDEX `fk_asset_serial1_idx` (`serialID` ASC),
  CONSTRAINT `fk_asset_assetStatus1`
    FOREIGN KEY (`statusID`)
    REFERENCES `trackingapp`.`status` (`statusID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_asset_brand1`
    FOREIGN KEY (`brandID`)
    REFERENCES `trackingapp`.`brand` (`brandID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_asset_location1`
    FOREIGN KEY (`locationID`)
    REFERENCES `trackingapp`.`location` (`locationID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_asset_model1`
    FOREIGN KEY (`modelID`)
    REFERENCES `trackingapp`.`model` (`modelID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_asset_serial1`
    FOREIGN KEY (`serialID`)
    REFERENCES `trackingapp`.`serial` (`serialID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `trackingapp`.`role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `trackingapp`.`role` (
  `roleID` INT(11) NOT NULL AUTO_INCREMENT,
  `roleName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`roleID`),
  UNIQUE INDEX `roleName_UNIQUE` (`roleName` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `trackingapp`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `trackingapp`.`user` (
  `userID` INT(11) NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `userpassword` VARCHAR(45) NOT NULL,
  `firstname` VARCHAR(45) NOT NULL,
  `lastname` VARCHAR(45) NOT NULL,
  `locationID` INT(11) NOT NULL,
  `roleID` INT(11) NOT NULL,
  PRIMARY KEY (`userID`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC),
  INDEX `fk_user_location_idx` (`locationID` ASC),
  INDEX `fk_user_role1_idx` (`roleID` ASC),
  CONSTRAINT `fk_user_location`
    FOREIGN KEY (`locationID`)
    REFERENCES `trackingapp`.`location` (`locationID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_role1`
    FOREIGN KEY (`roleID`)
    REFERENCES `trackingapp`.`role` (`roleID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `trackingapp`.`txntype`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `trackingapp`.`txntype` (
  `txnTypeID` INT(11) NOT NULL AUTO_INCREMENT,
  `txnTypeName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`txnTypeID`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `trackingapp`.`assetlog`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `trackingapp`.`assetlog` (
  `assetLogID` INT(11) NOT NULL AUTO_INCREMENT,
  `assetLogDate` DATE NOT NULL,
  `locationID` INT(11) NOT NULL,
  `assetID` INT(11) NOT NULL,
  `txnTypeID` INT(11) NOT NULL,
  `userID` INT(11) NOT NULL,
  PRIMARY KEY (`assetLogID`),
  INDEX `fk_log_location1_idx` (`locationID` ASC),
  INDEX `fk_log_asset1_idx` (`assetID` ASC),
  INDEX `fk_log_txnType1_idx` (`txnTypeID` ASC),
  INDEX `fk_assetLog_user1_idx` (`userID` ASC),
  CONSTRAINT `fk_assetLog_user1`
    FOREIGN KEY (`userID`)
    REFERENCES `trackingapp`.`user` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_log_asset1`
    FOREIGN KEY (`assetID`)
    REFERENCES `trackingapp`.`asset` (`assetID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_log_location1`
    FOREIGN KEY (`locationID`)
    REFERENCES `trackingapp`.`location` (`locationID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_log_txnType1`
    FOREIGN KEY (`txnTypeID`)
    REFERENCES `trackingapp`.`txntype` (`txnTypeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `trackingapp`.`remarks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `trackingapp`.`remarks` (
  `remarksID` INT(11) NOT NULL AUTO_INCREMENT,
  `remarksContent` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`remarksID`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `trackingapp`.`assetlog_has_remarks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `trackingapp`.`assetlog_has_remarks` (
  `assetLogID` INT(11) NOT NULL,
  `remarksID` INT(11) NOT NULL,
  INDEX `fk_assetLog_has_remarks_assetLog1_idx` (`assetLogID` ASC),
  INDEX `fk_assetLog_has_remarks_remarks1_idx` (`remarksID` ASC),
  CONSTRAINT `fk_assetLog_has_remarks_assetLog1`
    FOREIGN KEY (`assetLogID`)
    REFERENCES `trackingapp`.`assetlog` (`assetLogID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_assetLog_has_remarks_remarks1`
    FOREIGN KEY (`remarksID`)
    REFERENCES `trackingapp`.`remarks` (`remarksID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `trackingapp`.`spareparttype`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `trackingapp`.`spareparttype` (
  `sparePartTypeID` INT(11) NOT NULL AUTO_INCREMENT,
  `sparePartTypeName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`sparePartTypeID`),
  UNIQUE INDEX `sparePartTypeName_UNIQUE` (`sparePartTypeName` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 9
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `trackingapp`.`sparepart`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `trackingapp`.`sparepart` (
  `sparePartID` INT(11) NOT NULL AUTO_INCREMENT,
  `brandID` INT(11) NOT NULL,
  `modelID` INT(11) NOT NULL,
  `serialID` INT(11) NOT NULL,
  `locationID` INT(11) NOT NULL,
  `sparePartTypeID` INT(11) NOT NULL,
  `statusID` INT(11) NOT NULL,
  PRIMARY KEY (`sparePartID`),
  INDEX `fk_sparepart_brand1_idx` (`brandID` ASC),
  INDEX `fk_sparepart_model1_idx` (`modelID` ASC),
  INDEX `fk_sparepart_serial1_idx` (`serialID` ASC),
  INDEX `fk_sparepart_location1_idx` (`locationID` ASC),
  INDEX `fk_sparepart_sparePartType1_idx` (`sparePartTypeID` ASC),
  INDEX `fk_sparepart_status1_idx` (`statusID` ASC),
  CONSTRAINT `fk_sparepart_brand1`
    FOREIGN KEY (`brandID`)
    REFERENCES `trackingapp`.`brand` (`brandID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sparepart_location1`
    FOREIGN KEY (`locationID`)
    REFERENCES `trackingapp`.`location` (`locationID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sparepart_model1`
    FOREIGN KEY (`modelID`)
    REFERENCES `trackingapp`.`model` (`modelID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sparepart_serial1`
    FOREIGN KEY (`serialID`)
    REFERENCES `trackingapp`.`serial` (`serialID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sparepart_sparePartType1`
    FOREIGN KEY (`sparePartTypeID`)
    REFERENCES `trackingapp`.`spareparttype` (`sparePartTypeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sparepart_status1`
    FOREIGN KEY (`statusID`)
    REFERENCES `trackingapp`.`status` (`statusID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `trackingapp`.`sparepartlog`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `trackingapp`.`sparepartlog` (
  `sparePartLogID` INT(11) NOT NULL AUTO_INCREMENT,
  `sparePartLogDate` DATE NOT NULL,
  `locationID` INT(11) NOT NULL,
  `sparePartID` INT(11) NOT NULL,
  `txnTypeID` INT(11) NOT NULL,
  `userID` INT(11) NOT NULL,
  PRIMARY KEY (`sparePartLogID`),
  INDEX `fk_sparePartLog_location1_idx` (`locationID` ASC),
  INDEX `fk_sparePartLog_sparePart1_idx` (`sparePartID` ASC),
  INDEX `fk_sparePartLog_txnType1_idx` (`txnTypeID` ASC),
  INDEX `fk_sparePartLog_user1_idx` (`userID` ASC),
  CONSTRAINT `fk_sparePartLog_location1`
    FOREIGN KEY (`locationID`)
    REFERENCES `trackingapp`.`location` (`locationID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sparePartLog_sparePart1`
    FOREIGN KEY (`sparePartID`)
    REFERENCES `trackingapp`.`sparepart` (`sparePartID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sparePartLog_txnType1`
    FOREIGN KEY (`txnTypeID`)
    REFERENCES `trackingapp`.`txntype` (`txnTypeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sparePartLog_user1`
    FOREIGN KEY (`userID`)
    REFERENCES `trackingapp`.`user` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `trackingapp`.`sparepartlog_has_remarks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `trackingapp`.`sparepartlog_has_remarks` (
  `sparePartLogID` INT(11) NOT NULL,
  `remarksID` INT(11) NOT NULL,
  INDEX `fk_sparePartLog_has_remarks_sparePartLog1_idx` (`sparePartLogID` ASC),
  INDEX `fk_sparePartLog_has_remarks_remarks1_idx` (`remarksID` ASC),
  CONSTRAINT `fk_sparePartLog_has_remarks_remarks1`
    FOREIGN KEY (`remarksID`)
    REFERENCES `trackingapp`.`remarks` (`remarksID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_sparePartLog_has_remarks_sparePartLog1`
    FOREIGN KEY (`sparePartLogID`)
    REFERENCES `trackingapp`.`sparepartlog` (`sparePartLogID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `trackingapp`.`status`
-- -----------------------------------------------------
START TRANSACTION;
USE `trackingapp`;
INSERT INTO `trackingapp`.`status` (`statusID`, `statusName`) VALUES (1, 'Active');
INSERT INTO `trackingapp`.`status` (`statusID`, `statusName`) VALUES (2, 'Archived');
INSERT INTO `trackingapp`.`status` (`statusID`, `statusName`) VALUES (3, 'Faulty');

COMMIT;


-- -----------------------------------------------------
-- Data for table `trackingapp`.`scope`
-- -----------------------------------------------------
START TRANSACTION;
USE `trackingapp`;
INSERT INTO `trackingapp`.`scope` (`scopeID`, `scopeName`) VALUES (1, 'Assets');
INSERT INTO `trackingapp`.`scope` (`scopeID`, `scopeName`) VALUES (2, 'Spare Parts');

COMMIT;


-- -----------------------------------------------------
-- Data for table `trackingapp`.`brand`
-- -----------------------------------------------------
START TRANSACTION;
USE `trackingapp`;
INSERT INTO `trackingapp`.`brand` (`brandID`, `brandName`, `scopeID`) VALUES (1, 'HP', 1);
INSERT INTO `trackingapp`.`brand` (`brandID`, `brandName`, `scopeID`) VALUES (2, 'DELL', 1);
INSERT INTO `trackingapp`.`brand` (`brandID`, `brandName`, `scopeID`) VALUES (3, 'LENOVO', 1);
INSERT INTO `trackingapp`.`brand` (`brandID`, `brandName`, `scopeID`) VALUES (4, 'TARGUS', 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `trackingapp`.`locationtype`
-- -----------------------------------------------------
START TRANSACTION;
USE `trackingapp`;
INSERT INTO `trackingapp`.`locationtype` (`locationTypeID`, `locationTypeName`) VALUES (1, 'Store');
INSERT INTO `trackingapp`.`locationtype` (`locationTypeID`, `locationTypeName`) VALUES (2, 'School');

COMMIT;


-- -----------------------------------------------------
-- Data for table `trackingapp`.`state`
-- -----------------------------------------------------
START TRANSACTION;
USE `trackingapp`;
INSERT INTO `trackingapp`.`state` (`stateID`, `stateName`) VALUES (1, 'Johor');
INSERT INTO `trackingapp`.`state` (`stateID`, `stateName`) VALUES (2, 'Melaka');
INSERT INTO `trackingapp`.`state` (`stateID`, `stateName`) VALUES (3, 'Negeri Sembilan');

COMMIT;


-- -----------------------------------------------------
-- Data for table `trackingapp`.`location`
-- -----------------------------------------------------
START TRANSACTION;
USE `trackingapp`;
INSERT INTO `trackingapp`.`location` (`locationID`, `locationName`, `stateID`, `locationTypeID`) VALUES (1, 'KK Kuala Pilah', 3, 1);
INSERT INTO `trackingapp`.`location` (`locationID`, `locationName`, `stateID`, `locationTypeID`) VALUES (2, 'KK Batu Pahat', 1, 1);
INSERT INTO `trackingapp`.`location` (`locationID`, `locationName`, `stateID`, `locationTypeID`) VALUES (3, 'Poli Metro', 1, 1);
INSERT INTO `trackingapp`.`location` (`locationID`, `locationName`, `stateID`, `locationTypeID`) VALUES (4, 'BRC Muar', 1, 2);
INSERT INTO `trackingapp`.`location` (`locationID`, `locationName`, `stateID`, `locationTypeID`) VALUES (5, 'BRC UTHM', 1, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `trackingapp`.`model`
-- -----------------------------------------------------
START TRANSACTION;
USE `trackingapp`;
INSERT INTO `trackingapp`.`model` (`modelID`, `modelName`, `scopeID`) VALUES (1, '8640P', 1);
INSERT INTO `trackingapp`.`model` (`modelID`, `modelName`, `scopeID`) VALUES (2, 'E5440', 1);
INSERT INTO `trackingapp`.`model` (`modelID`, `modelName`, `scopeID`) VALUES (3, 'T440', 1);
INSERT INTO `trackingapp`.`model` (`modelID`, `modelName`, `scopeID`) VALUES (4, 'M100R', 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `trackingapp`.`serial`
-- -----------------------------------------------------
START TRANSACTION;
USE `trackingapp`;
INSERT INTO `trackingapp`.`serial` (`serialID`, `serialName`) VALUES (2, 'D985666');
INSERT INTO `trackingapp`.`serial` (`serialID`, `serialName`) VALUES (3, 'LEN23449');
INSERT INTO `trackingapp`.`serial` (`serialID`, `serialName`) VALUES (4, 'LEN23450');
INSERT INTO `trackingapp`.`serial` (`serialID`, `serialName`) VALUES (1, 'SGH123456');
INSERT INTO `trackingapp`.`serial` (`serialID`, `serialName`) VALUES (5, 'TAR1234');
INSERT INTO `trackingapp`.`serial` (`serialID`, `serialName`) VALUES (6, 'TAR1235');
INSERT INTO `trackingapp`.`serial` (`serialID`, `serialName`) VALUES (7, 'TAR1236');

COMMIT;


-- -----------------------------------------------------
-- Data for table `trackingapp`.`asset`
-- -----------------------------------------------------
START TRANSACTION;
USE `trackingapp`;
INSERT INTO `trackingapp`.`asset` (`assetID`, `brandID`, `modelID`, `serialID`, `locationID`, `statusID`) VALUES (1, 1, 1, 1, 4, 1);
INSERT INTO `trackingapp`.`asset` (`assetID`, `brandID`, `modelID`, `serialID`, `locationID`, `statusID`) VALUES (2, 2, 2, 2, 4, 1);
INSERT INTO `trackingapp`.`asset` (`assetID`, `brandID`, `modelID`, `serialID`, `locationID`, `statusID`) VALUES (3, 3, 3, 3, 1, 2);
INSERT INTO `trackingapp`.`asset` (`assetID`, `brandID`, `modelID`, `serialID`, `locationID`, `statusID`) VALUES (4, 3, 3, 4, 5, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `trackingapp`.`role`
-- -----------------------------------------------------
START TRANSACTION;
USE `trackingapp`;
INSERT INTO `trackingapp`.`role` (`roleID`, `roleName`) VALUES (1, 'Admin');
INSERT INTO `trackingapp`.`role` (`roleID`, `roleName`) VALUES (2, 'Store Keeper');

COMMIT;


-- -----------------------------------------------------
-- Data for table `trackingapp`.`user`
-- -----------------------------------------------------
START TRANSACTION;
USE `trackingapp`;
INSERT INTO `trackingapp`.`user` (`userID`, `username`, `userpassword`, `firstname`, `lastname`, `locationID`, `roleID`) VALUES (1, 'admin', '12345', 'System', 'Administrator', 4, 1);
INSERT INTO `trackingapp`.`user` (`userID`, `username`, `userpassword`, `firstname`, `lastname`, `locationID`, `roleID`) VALUES (2, 'user', '12345', 'Store', 'Keeper', 3, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `trackingapp`.`txntype`
-- -----------------------------------------------------
START TRANSACTION;
USE `trackingapp`;
INSERT INTO `trackingapp`.`txntype` (`txnTypeID`, `txnTypeName`) VALUES (1, 'Checkin');
INSERT INTO `trackingapp`.`txntype` (`txnTypeID`, `txnTypeName`) VALUES (2, 'Transfer');
INSERT INTO `trackingapp`.`txntype` (`txnTypeID`, `txnTypeName`) VALUES (3, 'Checkout');
INSERT INTO `trackingapp`.`txntype` (`txnTypeID`, `txnTypeName`) VALUES (4, 'Faulty');

COMMIT;


-- -----------------------------------------------------
-- Data for table `trackingapp`.`assetlog`
-- -----------------------------------------------------
START TRANSACTION;
USE `trackingapp`;
INSERT INTO `trackingapp`.`assetlog` (`assetLogID`, `assetLogDate`, `locationID`, `assetID`, `txnTypeID`, `userID`) VALUES (1, '2019-03-01', 4, 3, 1, 1);
INSERT INTO `trackingapp`.`assetlog` (`assetLogID`, `assetLogDate`, `locationID`, `assetID`, `txnTypeID`, `userID`) VALUES (2, '2019-03-02', 5, 3, 2, 1);
INSERT INTO `trackingapp`.`assetlog` (`assetLogID`, `assetLogDate`, `locationID`, `assetID`, `txnTypeID`, `userID`) VALUES (3, '2019-03-12', 4, 1, 1, 1);
INSERT INTO `trackingapp`.`assetlog` (`assetLogID`, `assetLogDate`, `locationID`, `assetID`, `txnTypeID`, `userID`) VALUES (4, '2019-03-12', 4, 2, 1, 1);
INSERT INTO `trackingapp`.`assetlog` (`assetLogID`, `assetLogDate`, `locationID`, `assetID`, `txnTypeID`, `userID`) VALUES (5, '2019-03-14', 1, 3, 3, 1);
INSERT INTO `trackingapp`.`assetlog` (`assetLogID`, `assetLogDate`, `locationID`, `assetID`, `txnTypeID`, `userID`) VALUES (6, '2019-03-14', 5, 4, 1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `trackingapp`.`remarks`
-- -----------------------------------------------------
START TRANSACTION;
USE `trackingapp`;
INSERT INTO `trackingapp`.`remarks` (`remarksID`, `remarksContent`) VALUES (1, 'IM1234');
INSERT INTO `trackingapp`.`remarks` (`remarksID`, `remarksContent`) VALUES (2, 'Swap from IM1234');

COMMIT;


-- -----------------------------------------------------
-- Data for table `trackingapp`.`assetlog_has_remarks`
-- -----------------------------------------------------
START TRANSACTION;
USE `trackingapp`;
INSERT INTO `trackingapp`.`assetlog_has_remarks` (`assetLogID`, `remarksID`) VALUES (5, 1);
INSERT INTO `trackingapp`.`assetlog_has_remarks` (`assetLogID`, `remarksID`) VALUES (6, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `trackingapp`.`spareparttype`
-- -----------------------------------------------------
START TRANSACTION;
USE `trackingapp`;
INSERT INTO `trackingapp`.`spareparttype` (`sparePartTypeID`, `sparePartTypeName`) VALUES (8, 'Adapter');
INSERT INTO `trackingapp`.`spareparttype` (`sparePartTypeID`, `sparePartTypeName`) VALUES (1, 'HDD');
INSERT INTO `trackingapp`.`spareparttype` (`sparePartTypeID`, `sparePartTypeName`) VALUES (6, 'Keyboard');
INSERT INTO `trackingapp`.`spareparttype` (`sparePartTypeID`, `sparePartTypeName`) VALUES (7, 'Mouse');
INSERT INTO `trackingapp`.`spareparttype` (`sparePartTypeID`, `sparePartTypeName`) VALUES (5, 'ODD');
INSERT INTO `trackingapp`.`spareparttype` (`sparePartTypeID`, `sparePartTypeName`) VALUES (4, 'Processor');
INSERT INTO `trackingapp`.`spareparttype` (`sparePartTypeID`, `sparePartTypeName`) VALUES (3, 'RAM');
INSERT INTO `trackingapp`.`spareparttype` (`sparePartTypeID`, `sparePartTypeName`) VALUES (2, 'SSHD');

COMMIT;


-- -----------------------------------------------------
-- Data for table `trackingapp`.`sparepart`
-- -----------------------------------------------------
START TRANSACTION;
USE `trackingapp`;
INSERT INTO `trackingapp`.`sparepart` (`sparePartID`, `brandID`, `modelID`, `serialID`, `locationID`, `sparePartTypeID`, `statusID`) VALUES (1, 4, 4, 5, 2, 7, 2);
INSERT INTO `trackingapp`.`sparepart` (`sparePartID`, `brandID`, `modelID`, `serialID`, `locationID`, `sparePartTypeID`, `statusID`) VALUES (2, 4, 4, 6, 4, 7, 1);
INSERT INTO `trackingapp`.`sparepart` (`sparePartID`, `brandID`, `modelID`, `serialID`, `locationID`, `sparePartTypeID`, `statusID`) VALUES (3, 4, 4, 7, 4, 7, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `trackingapp`.`sparepartlog`
-- -----------------------------------------------------
START TRANSACTION;
USE `trackingapp`;
INSERT INTO `trackingapp`.`sparepartlog` (`sparePartLogID`, `sparePartLogDate`, `locationID`, `sparePartID`, `txnTypeID`, `userID`) VALUES (1, '2019-02-21', 5, 1, 1, 1);
INSERT INTO `trackingapp`.`sparepartlog` (`sparePartLogID`, `sparePartLogDate`, `locationID`, `sparePartID`, `txnTypeID`, `userID`) VALUES (2, '2019-02-22', 5, 2, 1, 1);
INSERT INTO `trackingapp`.`sparepartlog` (`sparePartLogID`, `sparePartLogDate`, `locationID`, `sparePartID`, `txnTypeID`, `userID`) VALUES (3, '2019-02-21', 5, 3, 1, 1);
INSERT INTO `trackingapp`.`sparepartlog` (`sparePartLogID`, `sparePartLogDate`, `locationID`, `sparePartID`, `txnTypeID`, `userID`) VALUES (4, '2019-02-22', 4, 2, 2, 1);
INSERT INTO `trackingapp`.`sparepartlog` (`sparePartLogID`, `sparePartLogDate`, `locationID`, `sparePartID`, `txnTypeID`, `userID`) VALUES (5, '2019-02-22', 4, 1, 2, 1);
INSERT INTO `trackingapp`.`sparepartlog` (`sparePartLogID`, `sparePartLogDate`, `locationID`, `sparePartID`, `txnTypeID`, `userID`) VALUES (6, '2019-02-26', 2, 1, 3, 1);

COMMIT;

