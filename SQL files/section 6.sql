-- Which players committed the most fouls?
SELECT
    p.player_name,
    t.team_name,
    pd.fouls_for
FROM player_discipline pd
JOIN players p
    ON pd.player_id = p.player_id
JOIN teams t
    ON pd.team_id = t.team_id
ORDER BY pd.fouls_for DESC
LIMIT 10;

-- Which players suffered the most fouls?
SELECT
    p.player_name,
    t.team_name,
    pd.fouls_against
FROM player_discipline pd
JOIN players p
    ON pd.player_id = p.player_id
JOIN teams t
    ON pd.team_id = t.team_id
ORDER BY pd.fouls_against DESC
LIMIT 10;

-- Which players received the most yellow cards?
SELECT
    p.player_name,
    t.team_name,
    pd.yellow_cards
FROM player_discipline pd
JOIN players p
    ON pd.player_id = p.player_id
JOIN teams t
    ON pd.team_id = t.team_id
ORDER BY pd.yellow_cards DESC
LIMIT 10;

-- Which players received red cards?
SELECT
    p.player_name,
    t.team_name,
    pd.red_cards
FROM player_discipline pd
JOIN players p
    ON pd.player_id = p.player_id
JOIN teams t
    ON pd.team_id = t.team_id
WHERE pd.red_cards > 0
ORDER BY pd.red_cards DESC;

-- Which players received indirect red cards?
SELECT
    p.player_name,
    t.team_name,
    pd.indirect_red_cards
FROM player_discipline pd
JOIN players p
    ON pd.player_id = p.player_id
JOIN teams t
    ON pd.team_id = t.team_id
WHERE pd.indirect_red_cards > 0
ORDER BY pd.indirect_red_cards DESC;

-- Which players were caught offside most often?
SELECT
    p.player_name,
    t.team_name,
    pd.offsides
FROM player_discipline pd
JOIN players p
    ON pd.player_id = p.player_id
JOIN teams t
    ON pd.team_id = t.team_id
ORDER BY pd.offsides DESC
LIMIT 10;

-- Which players combined aggressive defending with discipline?
SELECT
    p.player_name,
    t.team_name,
    pd.fouls_for,
    pd.yellow_cards,
    def.forced_turnovers
FROM players p
JOIN player_discipline pd
    ON p.player_id = pd.player_id
JOIN player_defending def
    ON p.player_id = def.player_id
JOIN teams t
    ON pd.team_id = t.team_id
ORDER BY
    def.forced_turnovers DESC,
    pd.yellow_cards ASC
LIMIT 10;

-- Overall Discipline Ranking
SELECT
    p.player_name,
    t.team_name,
    pd.fouls_for,
    pd.yellow_cards,
    pd.red_cards,
    pd.offsides
FROM player_discipline pd
JOIN players p
    ON pd.player_id = p.player_id
JOIN teams t
    ON pd.team_id = t.team_id
ORDER BY
    pd.yellow_cards DESC,
    pd.red_cards DESC,
    pd.fouls_for DESC;