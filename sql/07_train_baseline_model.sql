CREATE OR REPLACE MODEL
  `ml-large-scale-portfolio.ecommerce_ml.conversion_model`
OPTIONS (
  model_type = 'logistic_reg',
  input_label_cols = ['label']
) AS
SELECT
  label,
  pageviews,
  hits,
  timeOnSite,
  deviceCategory,
  country,
  source,
  medium,
  day_of_week,
  month
FROM `ml-large-scale-portfolio.ecommerce_ml.train`;
