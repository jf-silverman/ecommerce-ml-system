SELECT
  COUNT(*) AS total_sessions,
  SUM(label) AS conversions,
  AVG(label) AS base_rate
FROM `ml-large-scale-portfolio.ecommerce_ml.test`;