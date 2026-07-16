-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema fifa_worldcup_2026
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema fifa_worldcup_2026
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `fifa_worldcup_2026` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `fifa_worldcup_2026` ;

-- -----------------------------------------------------
-- Table `fifa_worldcup_2026`.`teams`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fifa_worldcup_2026`.`teams` (
  `team_id` INT NOT NULL,
  `team_name` VARCHAR(100) NOT NULL,
  `team_code` CHAR(3) NOT NULL,
  PRIMARY KEY (`team_id`),
  UNIQUE INDEX `team_code` (`team_code` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `fifa_worldcup_2026`.`players`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fifa_worldcup_2026`.`players` (
  `player_id` INT NOT NULL,
  `player_name` VARCHAR(150) NOT NULL,
  `team_id` INT NOT NULL,
  `position` ENUM('GK', 'DF', 'MF', 'FW') NOT NULL,
  PRIMARY KEY (`player_id`),
  INDEX `fk_players_team` (`team_id` ASC) VISIBLE,
  CONSTRAINT `fk_players_team`
    FOREIGN KEY (`team_id`)
    REFERENCES `fifa_worldcup_2026`.`teams` (`team_id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `fifa_worldcup_2026`.`player_attacking`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fifa_worldcup_2026`.`player_attacking` (
  `player_id` INT NOT NULL,
  `team_id` INT NOT NULL,
  `assists` INT NULL DEFAULT NULL,
  `attempts_on_target` INT NULL DEFAULT NULL,
  `attempts_at_goal` INT NULL DEFAULT NULL,
  `attempts_at_goal_conv_rate` DECIMAL(5,2) NULL DEFAULT NULL,
  `attempts_inside_penalty` INT NULL DEFAULT NULL,
  `attempts_outside_penalty` INT NULL DEFAULT NULL,
  `headed_attempts_at_goal` INT NULL DEFAULT NULL,
  `xg` DECIMAL(6,2) NULL DEFAULT NULL,
  `xg_efficiency` VARCHAR(10) NULL DEFAULT NULL,
  `corners` INT NULL DEFAULT NULL,
  PRIMARY KEY (`player_id`, `team_id`),
  INDEX `fk_pa_team` (`team_id` ASC) VISIBLE,
  CONSTRAINT `fk_pa_player`
    FOREIGN KEY (`player_id`)
    REFERENCES `fifa_worldcup_2026`.`players` (`player_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_pa_team`
    FOREIGN KEY (`team_id`)
    REFERENCES `fifa_worldcup_2026`.`teams` (`team_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `fifa_worldcup_2026`.`player_defending`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fifa_worldcup_2026`.`player_defending` (
  `player_id` INT NOT NULL,
  `team_id` INT NOT NULL,
  `own_goals` INT NULL DEFAULT NULL,
  `forced_turnovers` INT NULL DEFAULT NULL,
  `defensive_pressures_applied` INT NULL DEFAULT NULL,
  `defensive_pressures_directly_applied` INT NULL DEFAULT NULL,
  PRIMARY KEY (`player_id`, `team_id`),
  INDEX `fk_pd_team` (`team_id` ASC) VISIBLE,
  CONSTRAINT `fk_pd_player`
    FOREIGN KEY (`player_id`)
    REFERENCES `fifa_worldcup_2026`.`players` (`player_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_pd_team`
    FOREIGN KEY (`team_id`)
    REFERENCES `fifa_worldcup_2026`.`teams` (`team_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `fifa_worldcup_2026`.`player_discipline`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fifa_worldcup_2026`.`player_discipline` (
  `player_id` INT NOT NULL,
  `team_id` INT NOT NULL,
  `fouls_against` INT NULL DEFAULT NULL,
  `fouls_for` INT NULL DEFAULT NULL,
  `yellow_cards` INT NULL DEFAULT NULL,
  `red_cards` INT NULL DEFAULT NULL,
  `indirect_red_cards` INT NULL DEFAULT NULL,
  `offsides` INT NULL DEFAULT NULL,
  PRIMARY KEY (`player_id`, `team_id`),
  INDEX `fk_pdis_team` (`team_id` ASC) VISIBLE,
  CONSTRAINT `fk_pdis_player`
    FOREIGN KEY (`player_id`)
    REFERENCES `fifa_worldcup_2026`.`players` (`player_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_pdis_team`
    FOREIGN KEY (`team_id`)
    REFERENCES `fifa_worldcup_2026`.`teams` (`team_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `fifa_worldcup_2026`.`player_distribution`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fifa_worldcup_2026`.`player_distribution` (
  `player_id` INT NOT NULL,
  `team_id` INT NOT NULL,
  `passes` INT NULL DEFAULT NULL,
  `passes_completed` INT NULL DEFAULT NULL,
  `passing_accuracy` DECIMAL(5,2) NULL DEFAULT NULL,
  `crosses` INT NULL DEFAULT NULL,
  `crossing_accuracy` DECIMAL(5,2) NULL DEFAULT NULL,
  `take_ons_completed` INT NULL DEFAULT NULL,
  `defensive_linebreaks_attempted` INT NULL DEFAULT NULL,
  `defensive_linebreaks_accuracy` DECIMAL(5,2) NULL DEFAULT NULL,
  `switches_of_play_attempted` INT NULL DEFAULT NULL,
  `switches_of_play_accuracy` DECIMAL(5,2) NULL DEFAULT NULL,
  PRIMARY KEY (`player_id`, `team_id`),
  INDEX `fk_pdist_team` (`team_id` ASC) VISIBLE,
  CONSTRAINT `fk_pdist_player`
    FOREIGN KEY (`player_id`)
    REFERENCES `fifa_worldcup_2026`.`players` (`player_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_pdist_team`
    FOREIGN KEY (`team_id`)
    REFERENCES `fifa_worldcup_2026`.`teams` (`team_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `fifa_worldcup_2026`.`player_goalkeeping`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fifa_worldcup_2026`.`player_goalkeeping` (
  `player_id` INT NOT NULL,
  `team_id` INT NOT NULL,
  `goalkeeper_saves` INT NULL DEFAULT NULL,
  `goalkeeper_action_inside_penalty_area` INT NULL DEFAULT NULL,
  `goalkeeper_action_outside_penalty_area` INT NULL DEFAULT NULL,
  PRIMARY KEY (`player_id`, `team_id`),
  INDEX `fk_pg_team` (`team_id` ASC) VISIBLE,
  CONSTRAINT `fk_pg_player`
    FOREIGN KEY (`player_id`)
    REFERENCES `fifa_worldcup_2026`.`players` (`player_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_pg_team`
    FOREIGN KEY (`team_id`)
    REFERENCES `fifa_worldcup_2026`.`teams` (`team_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `fifa_worldcup_2026`.`player_goalsbook`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fifa_worldcup_2026`.`player_goalsbook` (
  `player_id` INT NOT NULL,
  `team_id` INT NOT NULL,
  `goals` INT NULL DEFAULT NULL,
  `assists` INT NULL DEFAULT NULL,
  `minutes_played` INT NULL DEFAULT NULL,
  PRIMARY KEY (`player_id`, `team_id`),
  INDEX `fk_pgb_team` (`team_id` ASC) VISIBLE,
  CONSTRAINT `fk_pgb_player`
    FOREIGN KEY (`player_id`)
    REFERENCES `fifa_worldcup_2026`.`players` (`player_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_pgb_team`
    FOREIGN KEY (`team_id`)
    REFERENCES `fifa_worldcup_2026`.`teams` (`team_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `fifa_worldcup_2026`.`team_attacking`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fifa_worldcup_2026`.`team_attacking` (
  `team_id` INT NOT NULL,
  `goals` INT NULL DEFAULT NULL,
  `assists` INT NULL DEFAULT NULL,
  `attempts_at_goal` INT NULL DEFAULT NULL,
  `attempt_on_target` INT NULL DEFAULT NULL,
  `off_target_attempts` INT NULL DEFAULT NULL,
  `attempts_at_goal_conv_rate` DECIMAL(5,2) NULL DEFAULT NULL,
  `attempts_inside_the_penalty_area` INT NULL DEFAULT NULL,
  `attempts_outside_the_penalty_area` INT NULL DEFAULT NULL,
  `headed_attempts_at_goal` INT NULL DEFAULT NULL,
  `xg` DECIMAL(6,2) NULL DEFAULT NULL,
  `xg_efficiency` VARCHAR(10) NULL DEFAULT NULL,
  `corners` INT NULL DEFAULT NULL,
  `possession_control` DECIMAL(5,2) NULL DEFAULT NULL,
  PRIMARY KEY (`team_id`),
  CONSTRAINT `fk_ta_team`
    FOREIGN KEY (`team_id`)
    REFERENCES `fifa_worldcup_2026`.`teams` (`team_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `fifa_worldcup_2026`.`team_defending`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fifa_worldcup_2026`.`team_defending` (
  `team_id` INT NOT NULL,
  `own_goals` INT NULL DEFAULT NULL,
  `goals_conceded` INT NULL DEFAULT NULL,
  `forced_turnover` INT NULL DEFAULT NULL,
  `ball_recovery_time` DECIMAL(5,2) NULL DEFAULT NULL,
  `defensive_pressures_applied` INT NULL DEFAULT NULL,
  `defensive_pressures_directly_applied` INT NULL DEFAULT NULL,
  PRIMARY KEY (`team_id`),
  CONSTRAINT `fk_td_team`
    FOREIGN KEY (`team_id`)
    REFERENCES `fifa_worldcup_2026`.`teams` (`team_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `fifa_worldcup_2026`.`team_discipline`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fifa_worldcup_2026`.`team_discipline` (
  `team_id` INT NOT NULL,
  `fouls_against` INT NULL DEFAULT NULL,
  `fouls_for` INT NULL DEFAULT NULL,
  `yellow_cards` INT NULL DEFAULT NULL,
  `red_cards` INT NULL DEFAULT NULL,
  `indirect_red_cards` INT NULL DEFAULT NULL,
  `offsides` INT NULL DEFAULT NULL,
  PRIMARY KEY (`team_id`),
  CONSTRAINT `fk_tdis_team`
    FOREIGN KEY (`team_id`)
    REFERENCES `fifa_worldcup_2026`.`teams` (`team_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `fifa_worldcup_2026`.`team_distribution`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fifa_worldcup_2026`.`team_distribution` (
  `team_id` INT NOT NULL,
  `distribution_passes` INT NULL DEFAULT NULL,
  `passes_completed` INT NULL DEFAULT NULL,
  `passing_accuracy` DECIMAL(5,2) NULL DEFAULT NULL,
  `crosses` INT NULL DEFAULT NULL,
  `crossing_accuracy` DECIMAL(5,2) NULL DEFAULT NULL,
  `take_ons_completed` INT NULL DEFAULT NULL,
  `defensive_linebreaks_attempted` INT NULL DEFAULT NULL,
  `defensive_linebreaks_accuracy` DECIMAL(5,2) NULL DEFAULT NULL,
  `switches_of_play_attempted` INT NULL DEFAULT NULL,
  `switches_of_play_accuracy` DECIMAL(5,2) NULL DEFAULT NULL,
  PRIMARY KEY (`team_id`),
  CONSTRAINT `fk_tdist_team`
    FOREIGN KEY (`team_id`)
    REFERENCES `fifa_worldcup_2026`.`teams` (`team_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `fifa_worldcup_2026`.`team_goalkeeping`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fifa_worldcup_2026`.`team_goalkeeping` (
  `team_id` INT NOT NULL,
  `clean_sheets` INT NULL DEFAULT NULL,
  `goals_conceded` INT NULL DEFAULT NULL,
  `goalkeeper_saves` INT NULL DEFAULT NULL,
  `goalkeeper_actions_inside_the_penalty_area` INT NULL DEFAULT NULL,
  `goalkeeper_actions_outside_the_penalty_area` INT NULL DEFAULT NULL,
  PRIMARY KEY (`team_id`),
  CONSTRAINT `fk_tg_team`
    FOREIGN KEY (`team_id`)
    REFERENCES `fifa_worldcup_2026`.`teams` (`team_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
