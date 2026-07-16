-- Who scored the most goals?

-- Purpose: Identify the tournament's top scorers.

SELECT
    p.player_name,
    t.team_name,
    pg.goals
FROM player_goalsbook pg
JOIN players p
    ON pg.player_id = p.player_id
JOIN teams t
    ON pg.team_id = t.team_id
ORDER BY pg.goals DESC
LIMIT 10;

-- Which players provided the most assists?
SELECT
    p.player_name,
    t.team_name,
    pg.assists
FROM player_goalsbook pg
JOIN players p
    ON pg.player_id = p.player_id
JOIN teams t
    ON pg.team_id = t.team_id
ORDER BY pg.assists DESC
LIMIT 10;

-- Which players recorded the most goal contributions?

-- A more meaningful metric than goals alone.

SELECT
    p.player_name,
    t.team_name,
    pg.goals,
    pg.assists,
    (pg.goals + pg.assists) AS goal_contributions
FROM player_goalsbook pg
JOIN players p
    ON pg.player_id = p.player_id
JOIN teams t
    ON pg.team_id = t.team_id
ORDER BY goal_contributions DESC
LIMIT 10;

-- Which players were the most efficient scorers?

-- Goals per 90 minutes.

SELECT
    p.player_name,
    t.team_name,
    pg.goals,
    pg.minutes_played,
    ROUND((pg.goals * 90.0) / pg.minutes_played, 2) AS goals_per_90
FROM player_goalsbook pg
JOIN players p
    ON pg.player_id = p.player_id
JOIN teams t
    ON pg.team_id = t.team_id
WHERE pg.minutes_played > 0
ORDER BY goals_per_90 DESC
LIMIT 10;

-- Which players created the highest xG?
SELECT
    p.player_name,
    t.team_name,
    pa.xg
FROM player_attacking pa
JOIN players p
    ON pa.player_id = p.player_id
JOIN teams t
    ON pa.team_id = t.team_id
ORDER BY pa.xg DESC
LIMIT 10;

-- Which players generated the most shots?
SELECT
    p.player_name,
    t.team_name,
    pa.attempts_at_goal
FROM player_attacking pa
JOIN players p
    ON pa.player_id = p.player_id
JOIN teams t
    ON pa.team_id = t.team_id
ORDER BY pa.attempts_at_goal DESC
LIMIT 10;


-- Which players created the most chances?

-- Using assists from the attacking table.

SELECT
    p.player_name,
    t.team_name,
    pa.assists
FROM player_attacking pa
JOIN players p
    ON pa.player_id = p.player_id
JOIN teams t
    ON pa.team_id = t.team_id
ORDER BY pa.assists DESC
LIMIT 10;

-- Which players completed the most passes?
SELECT
    p.player_name,
    t.team_name,
    pd.passes_completed
FROM player_distribution pd
JOIN players p
    ON pd.player_id = p.player_id
JOIN teams t
    ON pd.team_id = t.team_id
ORDER BY pd.passes_completed DESC
LIMIT 10;

-- Which players had the highest passing accuracy?
SELECT
    p.player_name,
    t.team_name,
    pd.passing_accuracy
FROM player_distribution pd
JOIN players p
    ON pd.player_id = p.player_id
JOIN teams t
    ON pd.team_id = t.team_id
ORDER BY pd.passing_accuracy DESC
LIMIT 10;

-- Overall Player Performance Ranking

-- This combines attacking output into one view.

SELECT
    p.player_name,
    t.team_name,
    pg.goals,
    pg.assists,
    pa.xg,
    pg.minutes_played,
    (pg.goals + pg.assists) AS goal_contributions
FROM player_goalsbook pg
JOIN player_attacking pa
    ON pg.player_id = pa.player_id
JOIN players p
    ON pg.player_id = p.player_id
JOIN teams t
    ON pg.team_id = t.team_id
ORDER BY
    goal_contributions DESC,
    pa.xg DESC;