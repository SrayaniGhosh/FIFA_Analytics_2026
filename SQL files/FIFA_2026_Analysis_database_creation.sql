create database fifa_worldcup_2026;
use fifa_worldcup_2026;

SHOW GLOBAL VARIABLES LIKE 'local_infile';

SET GLOBAL local_infile = 1;

CREATE TABLE teams (
    team_id INT PRIMARY KEY,
    team_name VARCHAR(100) NOT NULL,
    team_code CHAR(3) NOT NULL UNIQUE
);

LOAD DATA LOCAL INFILE 'D:/Data Science IVY/SQL/FIFA/dataset used for analysis/teams.csv'
 INTO TABLE teams
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
 
 select * from teams;
 
 SELECT COUNT(*) FROM teams;
 
 
 CREATE TABLE players (
    player_id INT PRIMARY KEY,
    player_name VARCHAR(150) NOT NULL,
    team_id INT NOT NULL,
    position ENUM('GK','DF','MF','FW') NOT NULL,

    CONSTRAINT fk_players_team
        FOREIGN KEY (team_id)
        REFERENCES teams(team_id)
        ON UPDATE CASCADE
);

LOAD DATA LOCAL INFILE 'D:/Data Science IVY/SQL/FIFA/dataset used for analysis/players.csv'
 INTO TABLE players
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

select * from players;

CREATE TABLE player_attacking (
    player_id INT NOT NULL,
    team_id INT NOT NULL,

    assists INT,
    attempts_on_target INT,
    attempts_at_goal INT,
    attempts_at_goal_conv_rate DECIMAL(5,2),
    attempts_inside_penalty INT,
    attempts_outside_penalty INT,
    headed_attempts_at_goal INT,
    xg DECIMAL(6,2),
    xg_efficiency VARCHAR(10),
    corners INT,
    
	PRIMARY KEY (player_id, team_id),
    CONSTRAINT fk_pa_player
        FOREIGN KEY (player_id)
        REFERENCES players(player_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT fk_pa_team
        FOREIGN KEY (team_id)
        REFERENCES teams(team_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);
 
 LOAD DATA LOCAL INFILE 'D:/Data Science IVY/SQL/FIFA/dataset used for analysis/player_attacking.csv'
 INTO TABLE player_attacking
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

CREATE TABLE player_defending (
    player_id INT NOT NULL,
    team_id INT NOT NULL,

    own_goals INT,
    forced_turnovers INT,
    defensive_pressures_applied INT,
    defensive_pressures_directly_applied INT,

	PRIMARY KEY (player_id, team_id),
    
    CONSTRAINT fk_pd_player
        FOREIGN KEY (player_id)
        REFERENCES players(player_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT fk_pd_team
        FOREIGN KEY (team_id)
        REFERENCES teams(team_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

 LOAD DATA LOCAL INFILE 'D:/Data Science IVY/SQL/FIFA/dataset used for analysis/player_defending.csv'
 INTO TABLE player_defending
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

CREATE TABLE player_discipline (
    player_id INT NOT NULL,
    team_id INT NOT NULL,

    fouls_against INT,
    fouls_for INT,
    yellow_cards INT,
    red_cards INT,
    indirect_red_cards INT,
    offsides INT,
    
	PRIMARY KEY (player_id, team_id),
    
    CONSTRAINT fk_pdis_player
        FOREIGN KEY (player_id)
        REFERENCES players(player_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT fk_pdis_team
        FOREIGN KEY (team_id)
        REFERENCES teams(team_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

 LOAD DATA LOCAL INFILE 'D:/Data Science IVY/SQL/FIFA/dataset used for analysis/player_discipline.csv'
 INTO TABLE player_discipline
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

CREATE TABLE player_distribution (
    player_id INT NOT NULL,
    team_id INT NOT NULL,

    passes INT,
    passes_completed INT,
    passing_accuracy DECIMAL(5,2),
    crosses INT,
    crossing_accuracy DECIMAL(5,2),
    take_ons_completed INT,
    defensive_linebreaks_attempted INT,
    defensive_linebreaks_accuracy DECIMAL(5,2),
    switches_of_play_attempted INT,
    switches_of_play_accuracy DECIMAL(5,2),

	PRIMARY KEY (player_id, team_id),
    
    CONSTRAINT fk_pdist_player
        FOREIGN KEY (player_id)
        REFERENCES players(player_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT fk_pdist_team
        FOREIGN KEY (team_id)
        REFERENCES teams(team_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

LOAD DATA LOCAL INFILE 'D:/Data Science IVY/SQL/FIFA/dataset used for analysis/player_distribution.csv'
 INTO TABLE player_distribution
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

CREATE TABLE player_goalkeeping (
    player_id INT NOT NULL,
    team_id INT NOT NULL,

    goalkeeper_saves INT,
    goalkeeper_action_inside_penalty_area INT,
    goalkeeper_action_outside_penalty_area INT,

    CONSTRAINT fk_pg_player
        FOREIGN KEY (player_id)
        REFERENCES players(player_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
        
		PRIMARY KEY (player_id, team_id),
        
    CONSTRAINT fk_pg_team
        FOREIGN KEY (team_id)
        REFERENCES teams(team_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

LOAD DATA LOCAL INFILE 'D:/Data Science IVY/SQL/FIFA/dataset used for analysis/player_goalkeeping.csv'
 INTO TABLE player_goalkeeping
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

CREATE TABLE player_goalsbook (
    player_id INT NOT NULL,
    team_id INT NOT NULL,

    goals INT,
    assists INT,
    minutes_played INT,

	PRIMARY KEY (player_id, team_id),
	
    CONSTRAINT fk_pgb_player
        FOREIGN KEY (player_id)
        REFERENCES players(player_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,


    CONSTRAINT fk_pgb_team
        FOREIGN KEY (team_id)
        REFERENCES teams(team_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

LOAD DATA LOCAL INFILE 'D:/Data Science IVY/SQL/FIFA/dataset used for analysis/player_goalsbook.csv'
 INTO TABLE player_goalsbook
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

CREATE TABLE team_attacking (
    team_id INT PRIMARY KEY,

    goals INT,
    assists INT,
    attempts_at_goal INT,
    attempt_on_target INT,
    off_target_attempts INT,
    attempts_at_goal_conv_rate DECIMAL(5,2),
    attempts_inside_the_penalty_area INT,
    attempts_outside_the_penalty_area INT,
    headed_attempts_at_goal INT,
    xg DECIMAL(6,2),
    xg_efficiency VARCHAR(10),
    corners INT,
    possession_control DECIMAL(5,2),

    CONSTRAINT fk_ta_team
        FOREIGN KEY (team_id)
        REFERENCES teams(team_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

LOAD DATA LOCAL INFILE 'D:/Data Science IVY/SQL/FIFA/dataset used for analysis/team_attacking.csv'
 INTO TABLE team_attacking
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

CREATE TABLE team_defending (
    team_id INT PRIMARY KEY,

    own_goals INT,
    goals_conceded INT,
    forced_turnover INT,
    ball_recovery_time DECIMAL(5,2),
    defensive_pressures_applied INT,
    defensive_pressures_directly_applied INT,

    CONSTRAINT fk_td_team
        FOREIGN KEY (team_id)
        REFERENCES teams(team_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

LOAD DATA LOCAL INFILE 'D:/Data Science IVY/SQL/FIFA/dataset used for analysis/team_defending.csv'
 INTO TABLE team_defending
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

CREATE TABLE team_discipline (
    team_id INT PRIMARY KEY,

    fouls_against INT,
    fouls_for INT,
    yellow_cards INT,
    red_cards INT,
    indirect_red_cards INT,
    offsides INT,

    CONSTRAINT fk_tdis_team
        FOREIGN KEY (team_id)
        REFERENCES teams(team_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);


LOAD DATA LOCAL INFILE 'D:/Data Science IVY/SQL/FIFA/dataset used for analysis/team_discipline.csv'
 INTO TABLE team_discipline
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

CREATE TABLE team_distribution (
    team_id INT PRIMARY KEY,

    distribution_passes INT,
    passes_completed INT,
    passing_accuracy DECIMAL(5,2),
    crosses INT,
    crossing_accuracy DECIMAL(5,2),
    take_ons_completed INT,
    defensive_linebreaks_attempted INT,
    defensive_linebreaks_accuracy DECIMAL(5,2),
    switches_of_play_attempted INT,
    switches_of_play_accuracy DECIMAL(5,2),

    CONSTRAINT fk_tdist_team
        FOREIGN KEY (team_id)
        REFERENCES teams(team_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

LOAD DATA LOCAL INFILE 'D:/Data Science IVY/SQL/FIFA/dataset used for analysis/team_distribution.csv'
 INTO TABLE team_distribution
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

CREATE TABLE team_goalkeeping (
    team_id INT PRIMARY KEY,

    clean_sheets INT,
    goals_conceded INT,
    goalkeeper_saves INT,
    goalkeeper_actions_inside_the_penalty_area INT,
    goalkeeper_actions_outside_the_penalty_area INT,

    CONSTRAINT fk_tg_team
        FOREIGN KEY (team_id)
        REFERENCES teams(team_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

LOAD DATA LOCAL INFILE 'D:/Data Science IVY/SQL/FIFA/dataset used for analysis/team_goalkeeping.csv'
 INTO TABLE team_goalkeeping
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

select * from teams;
select * from players;
select * from player_attacking;
select * from player_defending;
select * from player_discipline;
select * from player_distribution;
select * from player_goalkeeping;
select * from player_goalsbook;
select * from team_attacking;
select * from team_defending;
select * from team_discipline;
select * from team_distribution;
select * from team_goalkeeping;