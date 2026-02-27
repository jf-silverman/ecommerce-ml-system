SELECT
  COUNT(*) AS total_sessions,
  COUNTIF(transactions > 0) AS sessions_with_transactions,
  COUNTIF(transactions = 0 OR transactions IS NULL) AS sessions_without_transactions
FROM `ml-large-scale-portfolio.ecommerce_staging.sessions_clean`;