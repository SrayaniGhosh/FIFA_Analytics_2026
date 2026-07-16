-- Which teams completed the most passes?

-- Purpose: Identify teams that controlled possession through passing.

SELECT
    t.team_name,
    td.passes_completed
FROM team_distribution td
JOIN teams t
ON td.team_id = t.team_id
ORDER BY td.passes_completed DESC
LIMIT 10;

-- Which teams had the highest passing accuracy?

-- Purpose: Measure passing efficiency.

SELECT
    t.team_name,
    td.passing_accuracy
FROM team_distribution td
JOIN teams t
ON td.team_id = t.team_id
ORDER BY td.passing_accuracy DESC
LIMIT 10;

-- Which teams attempted the most passes?

-- Shows overall ball circulation.

SELECT
    t.team_name,
    td.distribution_passes
FROM team_distribution td
JOIN teams t
ON td.team_id = t.team_id
ORDER BY td.distribution_passes DESC
LIMIT 10;

-- Which teams completed the most crosses?
SELECT
    t.team_name,
    td.crosses
FROM team_distribution td
JOIN teams t
ON td.team_id = t.team_id
ORDER BY td.crosses DESC
LIMIT 10;

-- Which teams had the highest crossing accuracy?
SELECT
    t.team_name,
    td.crossing_accuracy
FROM team_distribution td
JOIN teams t
ON td.team_id = t.team_id
ORDER BY td.crossing_accuracy DESC
LIMIT 10;

-- Which teams completed the most take-ons?

SELECT
    t.team_name,
    td.take_ons_completed
FROM team_distribution td
JOIN teams t
ON td.team_id = t.team_id
ORDER BY td.take_ons_completed DESC
LIMIT 10;

-- Which teams attempted the most defensive line-breaking passes?
SELECT
    t.team_name,
    td.defensive_linebreaks_attempted
FROM team_distribution td
JOIN teams t
ON td.team_id = t.team_id
ORDER BY td.defensive_linebreaks_attempted DESC
LIMIT 10;

-- Which teams executed line-breaking passes most accurately?
SELECT
    t.team_name,
    td.defensive_linebreaks_accuracy
FROM team_distribution td
JOIN teams t
ON td.team_id = t.team_id
ORDER BY td.defensive_linebreaks_accuracy DESC
LIMIT 10;

-- Which teams switched play most effectively?
SELECT
    t.team_name,
    td.switches_of_play_accuracy
FROM team_distribution td
JOIN teams t
ON td.team_id = t.team_id
ORDER BY td.switches_of_play_accuracy DESC
LIMIT 10;


-- Overall Ball Distribution Ranking
SELECT
    t.team_name,
    td.distribution_passes,
    td.passes_completed,
    td.passing_accuracy,
    td.crosses,
    td.take_ons_completed
FROM team_distribution td
JOIN teams t
ON td.team_id = t.team_id
ORDER BY
    td.passing_accuracy DESC,
    td.passes_completed DESC;