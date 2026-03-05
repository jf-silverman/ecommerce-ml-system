SELECT
  percentile_bucket,
  COUNT(*) AS sessions,
  AVG(label) AS conversion_rate
FROM `ml-large-scale-portfolio.ecommerce_ml.test_predictions_ranked`
GROUP BY percentile_bucket
ORDER BY percentile_bucket;