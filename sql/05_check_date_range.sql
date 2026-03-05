SELECT
  MIN(session_date) AS min_date,
  MAX(session_date) AS max_date,
  COUNT(*) AS total_rows
FROM `ml-large-scale-portfolio.ecommerce_staging.session_features`;