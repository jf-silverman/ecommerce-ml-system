CREATE OR REPLACE TABLE ecommerce_raw.sessions AS
SELECT *
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_*`
WHERE totals.visits = 1