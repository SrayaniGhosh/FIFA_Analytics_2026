-- Which teams scored the most goals?
-- Purpose: Identifying the strongest attacking teams.

SELECT
    t.team_name,
    ta.goals
FROM team_attacking ta
JOIN teams t
ON ta.team_id = t.team_id
ORDER BY ta.goals DESC
LIMIT 10;

-- Which teams created the most scoring opportunities?

SELECT
    t.team_name,
    ta.attempts_at_goal
FROM team_attacking ta
JOIN teams t
ON ta.team_id = t.team_id
ORDER BY ta.attempts_at_goal DESC
LIMIT 10;

-- Which teams were the most accurate in front of goal?

SELECT
    t.team_name,
    ta.attempt_on_target
FROM team_attacking ta
JOIN teams t
ON ta.team_id = t.team_id
ORDER BY ta.attempt_on_target DESC
LIMIT 10;

-- Which teams had the highest shot conversion rate?

SELECT
    t.team_name,
    ta.attempts_at_goal_conv_rate
FROM team_attacking ta
JOIN teams t
ON ta.team_id = t.team_id
ORDER BY ta.attempts_at_goal_conv_rate DESC
LIMIT 10;

-- Which teams generated the highest Expected Goals (xG)?
SELECT
    t.team_name,
    ta.xg
FROM team_attacking ta
JOIN teams t
ON ta.team_id = t.team_id
ORDER BY ta.xg DESC
LIMIT 10;

-- Which teams outperformed their Expected Goals?

SELECT
    t.team_name,
    ta.goals,
    ta.xg,
    ROUND(ta.goals - ta.xg,2) AS goals_above_xg
FROM team_attacking ta
JOIN teams t
ON ta.team_id = t.team_id
ORDER BY goals_above_xg DESC
LIMIT 10;

-- Which teams relied more on attacks inside the penalty area?
SELECT
    t.team_name,
    ta.attempts_inside_the_penalty_area,
    ta.attempts_outside_the_penalty_area
FROM team_attacking ta
JOIN teams t
ON ta.team_id = t.team_id
ORDER BY ta.attempts_inside_the_penalty_area DESC
LIMIT 10;

-- Which teams attempted the most headers?
SELECT
    t.team_name,
    ta.headed_attempts_at_goal
FROM team_attacking ta
JOIN teams t
ON ta.team_id = t.team_id
ORDER BY ta.headed_attempts_at_goal DESC
LIMIT 10;

-- Which teams created the most attacking pressure from set pieces?
SELECT
    t.team_name,
    ta.corners
FROM team_attacking ta
JOIN teams t
ON ta.team_id = t.team_id
ORDER BY ta.corners DESC
LIMIT 10;

-- Overall Attacking Ranking

SELECT
    t.team_name,
    ta.goals,
    ta.attempts_at_goal,
    ta.attempt_on_target,
    ta.xg,
    ta.corners
FROM team_attacking ta
JOIN teams t
ON ta.team_id = t.team_id
ORDER BY
    ta.goals DESC,
    ta.attempt_on_target DESC,
    ta.xg DESC;