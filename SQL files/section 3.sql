-- Which teams conceded the fewest goals?

-- Purpose: Identifying the strongest defensive teams.

SELECT
    t.team_name,
    td.goals_conceded
FROM team_defending td
JOIN teams t
ON td.team_id = t.team_id
ORDER BY td.goals_conceded ASC
LIMIT 10;

-- Which teams kept the most clean sheets?

-- Purpose: Measure defensive consistency.

SELECT
    t.team_name,
    tg.clean_sheets
FROM team_goalkeeping tg
JOIN teams t
ON tg.team_id = t.team_id
ORDER BY tg.clean_sheets DESC
LIMIT 10;


-- Which teams forced the most turnovers?

-- Purpose: Identify teams that won possession through defensive actions.

SELECT
    t.team_name,
    td.forced_turnover
FROM team_defending td
JOIN teams t
ON td.team_id = t.team_id
ORDER BY td.forced_turnover DESC
LIMIT 10;

-- Which teams recovered possession the fastest?

-- A lower recovery time indicates quicker ball recovery after losing possession.

SELECT
    t.team_name,
    td.ball_recovery_time
FROM team_defending td
JOIN teams t
ON td.team_id = t.team_id
ORDER BY td.ball_recovery_time ASC
LIMIT 10;

-- Which teams applied the highest defensive pressure?
SELECT
    t.team_name,
    td.defensive_pressures_applied
FROM team_defending td
JOIN teams t
ON td.team_id = t.team_id
ORDER BY td.defensive_pressures_applied DESC
LIMIT 10;

-- Which teams generated the most direct defensive pressures?
SELECT
    t.team_name,
    td.defensive_pressures_directly_applied
FROM team_defending td
JOIN teams t
ON td.team_id = t.team_id
ORDER BY td.defensive_pressures_directly_applied DESC
LIMIT 10;

--  Which teams scored the fewest own goals?
SELECT
    t.team_name,
    td.own_goals
FROM team_defending td
JOIN teams t
ON td.team_id = t.team_id
ORDER BY td.own_goals ASC, td.goals_conceded ASC
LIMIT 10;

-- Which goalkeepers made the most saves?
SELECT
    t.team_name,
    tg.goalkeeper_saves
FROM team_goalkeeping tg
JOIN teams t
ON tg.team_id = t.team_id
ORDER BY tg.goalkeeper_saves DESC
LIMIT 10;

-- Which teams combined strong defending with effective goalkeeping?

-- This combines two defensive perspectives.

SELECT
    t.team_name,
    td.goals_conceded,
    tg.clean_sheets,
    tg.goalkeeper_saves
FROM teams t
JOIN team_defending td
ON t.team_id = td.team_id
JOIN team_goalkeeping tg
ON t.team_id = tg.team_id
ORDER BY
    td.goals_conceded ASC,
    tg.clean_sheets DESC;
    
    
-- Overall Defensive Ranking
SELECT
    t.team_name,
    td.goals_conceded,
    tg.clean_sheets,
    td.forced_turnover,
    td.defensive_pressures_applied
FROM teams t
JOIN team_defending td
ON t.team_id = td.team_id
JOIN team_goalkeeping tg
ON t.team_id = tg.team_id
ORDER BY
    td.goals_conceded ASC,
    tg.clean_sheets DESC,
    td.forced_turnover DESC;