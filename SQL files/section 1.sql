-- How many teams participated in the tournament?
SELECT COUNT(*) AS total_teams
FROM teams;

-- How many players participated in the tournament?
SELECT COUNT(*) AS total_players
FROM players;

-- Which teams scored the most goals?
SELECT
    t.team_name,
    ta.goals
FROM team_attacking ta
JOIN teams t
ON ta.team_id = t.team_id
ORDER BY ta.goals DESC
LIMIT 10;

-- Which teams conceded the fewest goals?
SELECT
    t.team_name,
    td.goals_conceded
FROM team_defending td
JOIN teams t
ON td.team_id = t.team_id
ORDER BY td.goals_conceded ASC
LIMIT 10;

-- Which teams kept the most clean sheets?
SELECT
    t.team_name,
    tg.clean_sheets
FROM team_goalkeeping tg
JOIN teams t
ON tg.team_id = t.team_id
ORDER BY tg.clean_sheets DESC
LIMIT 10;

-- Which teams had the highest possession?
SELECT
    t.team_name,
    ta.possession_control
FROM team_attacking ta
JOIN teams t
ON ta.team_id = t.team_id
ORDER BY ta.possession_control DESC
LIMIT 10;

-- Which teams attempted the most shots?
SELECT
    t.team_name,
    ta.attempts_at_goal
FROM team_attacking ta
JOIN teams t
ON ta.team_id = t.team_id
ORDER BY ta.attempts_at_goal DESC
LIMIT 10;

-- Which teams had the highest passing accuracy?
SELECT
    t.team_name,
    td.passing_accuracy
FROM team_distribution td
JOIN teams t
ON td.team_id = t.team_id
ORDER BY td.passing_accuracy DESC
LIMIT 10;

-- Which teams completed the most passes?
SELECT
    t.team_name,
    td.passes_completed
FROM team_distribution td
JOIN teams t
ON td.team_id = t.team_id
ORDER BY td.passes_completed DESC
LIMIT 10;

-- Which teams earned the most corners?
SELECT
    t.team_name,
    ta.corners
FROM team_attacking ta
JOIN teams t
ON ta.team_id = t.team_id
ORDER BY ta.corners DESC
LIMIT 10;

-- Which teams committed the most fouls?
SELECT
    t.team_name,
    td.fouls_for
FROM team_discipline td
JOIN teams t
ON td.team_id = t.team_id
ORDER BY td.fouls_for DESC
LIMIT 10;

-- Which teams received the most yellow cards?
SELECT
    t.team_name,
    td.yellow_cards
FROM team_discipline td
JOIN teams t
ON td.team_id = t.team_id
ORDER BY td.yellow_cards DESC
LIMIT 10;