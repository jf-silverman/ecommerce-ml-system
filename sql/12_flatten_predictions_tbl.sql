CREATE OR REPLACE TABLE
  `ml-large-scale-portfolio.ecommerce_ml.test_predictions_flat`
AS
SELECT
  fullVisitorId,
  visitId,
  session_date,
  label,
  predicted_label,

  -- convert probability of "no purchase" into probability of purchase
  1 - predicted_probability.prob AS predicted_probability

FROM `ml-large-scale-portfolio.ecommerce_ml.test_predictions`;