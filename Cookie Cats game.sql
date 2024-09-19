WITH
  selected_data AS (
  SELECT
    version AS game_version,
    COUNT (DISTINCT user_id) AS no_of_users,
    SUM (CASE
        WHEN retention_1 = TRUE THEN 1
        ELSE 0
    END
      ) AS no_of_retention_1,
    SUM (CASE
        WHEN retention_2 = TRUE THEN 1
        ELSE 0
    END
      ) AS no_of_retention_7,
    AVG(sum_gamerounds) AS mean_of_gamerounds,
    STDDEV(sum_gamerounds) AS stddev_of_gamerounds,
    MIN(sum_gamerounds) AS min_value,
    MAX(sum_gamerounds) AS max_value
  FROM
    `tc-da-1.turing_data_analytics.cookie_cats`
  GROUP BY
    game_version),
  percentiles_data AS (
  SELECT
    version AS game_version,
    PERCENTILE_CONT(sum_gamerounds, 0.50) OVER (PARTITION BY version) AS median_of_gamerounds,
    PERCENTILE_CONT(sum_gamerounds, 0.99) OVER (PARTITION BY version) AS p99_of_gamerounds
  FROM
    `tc-da-1.turing_data_analytics.cookie_cats`)
SELECT
  selected_data.game_version,
  no_of_users,
  no_of_retention_1,
  no_of_retention_1/no_of_users AS retention_1_rate,
  no_of_retention_7,
  no_of_retention_7/no_of_users AS retention_7_rate,
  mean_of_gamerounds,
  stddev_of_gamerounds,
  min_value,
  median_of_gamerounds,
  p99_of_gamerounds,
  max_value
FROM
  selected_data
INNER JOIN
  percentiles_data
ON
  selected_data.game_version = percentiles_data.game_version
GROUP BY
  selected_data.game_version,
  no_of_users,
  no_of_retention_1,
  no_of_retention_7,
  mean_of_gamerounds,
  min_value,
  stddev_of_gamerounds,
  median_of_gamerounds,
  p99_of_gamerounds,
  max_value