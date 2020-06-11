-- MySQL Script generated by MySQL Workbench
-- Thu Jun  4 11:22:53 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`User`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`User` ;

CREATE TABLE IF NOT EXISTS `mydb`.`User` (
  `User_id` INT NOT NULL auto_increment,
  `name` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NULL,
  `language` VARCHAR(2) NOT NULL DEFAULT 'en',
  `isModerator` TINYINT NOT NULL DEFAULT 0,
  `logins` VARCHAR(45) NULL,
  `watched` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`User_id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Group` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Group` (
  `Group_id` INT NOT NULL auto_increment,
  `name` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NULL,
  PRIMARY KEY (`Group_id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`Invitation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Invitation` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Invitation` (
  `User_User_id` INT NOT NULL,
  `Group_Group_id` INT NOT NULL,
  PRIMARY KEY (`User_User_id`, `Group_Group_id`),
  INDEX `fk_Invitation_Group1_idx` (`Group_Group_id` ASC),
  INDEX `fk_Invitation_User_idx` (`User_User_id` ASC),
  CONSTRAINT `fk_Invitation_User`
    FOREIGN KEY (`User_User_id`)
    REFERENCES `mydb`.`User` (`User_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Invitation_Group1`
    FOREIGN KEY (`Group_Group_id`)
    REFERENCES `mydb`.`Group` (`Group_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`User_has_Group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`User_has_Group` ;

CREATE TABLE IF NOT EXISTS `mydb`.`User_has_Group` (
  `User_User_id` INT NOT NULL,
  `Group_Group_id` INT NOT NULL,
  PRIMARY KEY (`User_User_id`, `Group_Group_id`),
  INDEX `fk_User_has_Group_Group1_idx` (`Group_Group_id` ASC),
  INDEX `fk_User_has_Group_User_idx` (`User_User_id` ASC),
  CONSTRAINT `fk_User_has_Group_User`
    FOREIGN KEY (`User_User_id`)
    REFERENCES `mydb`.`User` (`User_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_User_has_Group_Group1`
    FOREIGN KEY (`Group_Group_id`)
    REFERENCES `mydb`.`Group` (`Group_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Group_has_Group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Group_has_Group` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Group_has_Group` (
  `super_Group_id` INT NOT NULL,
  `sub_Group_id` INT NOT NULL,
  PRIMARY KEY (`super_Group_id`, `sub_Group_id`),
  INDEX `fk_Group_has_Group_Group2_idx` (`sub_Group_id` ASC),
  INDEX `fk_Group_has_Group_Group1_idx` (`super_Group_id` ASC),
  CONSTRAINT `fk_Group_has_Group_Group1`
    FOREIGN KEY (`super_Group_id`)
    REFERENCES `mydb`.`Group` (`Group_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Group_has_Group_Group2`
    FOREIGN KEY (`sub_Group_id`)
    REFERENCES `mydb`.`Group` (`Group_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`User_moderates_Group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`User_moderates_Group` ;

CREATE TABLE IF NOT EXISTS `mydb`.`User_moderates_Group` (
  `User_User_id` INT NOT NULL,
  `Group_Group_id` INT NOT NULL,
  PRIMARY KEY (`User_User_id`, `Group_Group_id`),
  INDEX `fk_User_has_Group1_Group1_idx` (`Group_Group_id` ASC),
  INDEX `fk_User_has_Group1_User1_idx` (`User_User_id` ASC),
  CONSTRAINT `fk_User_has_Group1_User1`
    FOREIGN KEY (`User_User_id`)
    REFERENCES `mydb`.`User` (`User_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_User_has_Group1_Group1`
    FOREIGN KEY (`Group_Group_id`)
    REFERENCES `mydb`.`Group` (`Group_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`User_follows_User`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`User_follows_User` ;

CREATE TABLE IF NOT EXISTS `mydb`.`User_follows_User` (
  `follower_id` INT NOT NULL,
  `followee_id` INT NOT NULL,
  PRIMARY KEY (`follower_id`, `followee_id`),
  INDEX `fk_User_has_User_User2_idx` (`followee_id` ASC),
  INDEX `fk_User_has_User_User1_idx` (`follower_id` ASC),
  CONSTRAINT `fk_User_has_User_User1`
    FOREIGN KEY (`follower_id`)
    REFERENCES `mydb`.`User` (`User_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_User_has_User_User2`
    FOREIGN KEY (`followee_id`)
    REFERENCES `mydb`.`User` (`User_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`User_follows_Group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`User_follows_Group` ;

CREATE TABLE IF NOT EXISTS `mydb`.`User_follows_Group` (
  `User_User_id` INT NOT NULL,
  `Group_Group_id` INT NOT NULL,
  PRIMARY KEY (`User_User_id`, `Group_Group_id`),
  INDEX `fk_User_has_Group1_Group2_idx` (`Group_Group_id` ASC),
  INDEX `fk_User_has_Group1_User2_idx` (`User_User_id` ASC),
  CONSTRAINT `fk_User_has_Group1_User2`
    FOREIGN KEY (`User_User_id`)
    REFERENCES `mydb`.`User` (`User_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_User_has_Group1_Group2`
    FOREIGN KEY (`Group_Group_id`)
    REFERENCES `mydb`.`Group` (`Group_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
