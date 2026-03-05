CREATE OR REPLACE TABLE
  `ml-large-scale-portfolio.ecommerce_ml.test_predictions`
AS
SELECT
  fullVisitorId,
  visitId,
  session_date,
  label,  -- actual label from test set
  predicted_label,
  predicted_probability
FROM
  ML.PREDICT(MODEL `ml-large-scale-portfolio.ecommerce_ml.conversion_model`,
    (
      SELECT *
      FROM `ml-large-scale-portfolio.ecommerce_ml.test`
    )
  );