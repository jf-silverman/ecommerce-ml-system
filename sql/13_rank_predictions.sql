CREATE OR REPLACE TABLE
  `ml-large-scale-portfolio.ecommerce_ml.test_predictions_ranked`
AS
SELECT
  *,
  NTILE(100) OVER (ORDER BY predicted_probability DESC) AS percentile_bucket
FROM `ml-large-scale-portfolio.ecommerce_ml.test_predictions_flat`;