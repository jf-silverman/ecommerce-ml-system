CREATE OR REPLACE TABLE `ml-large-scale-portfolio.ecommerce_ml.daily_predictions_gbt`
AS
SELECT
  fullVisitorId,
  visitId,
  session_date,
  label,
  predicted_label,
  (
    SELECT p.prob
    FROM UNNEST(predicted_label_probs) AS p
    WHERE CAST(p.label AS INT64) = 1
  ) AS predicted_probability
FROM ML.PREDICT(
  MODEL `ml-large-scale-portfolio.ecommerce_ml.conversion_model_gbt`,
  (
    SELECT *
    FROM `ml-large-scale-portfolio.ecommerce_ml.test_enhanced`
  )
);