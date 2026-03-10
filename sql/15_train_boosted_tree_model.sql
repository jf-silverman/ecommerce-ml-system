CREATE OR REPLACE MODEL
  `ml-large-scale-portfolio.ecommerce_ml.conversion_model_gbt`
OPTIONS(
  model_type='BOOSTED_TREE_CLASSIFIER',
  input_label_cols=['label'],
  max_iterations=50,
  max_tree_depth=6,
  learn_rate=0.2,
  subsample=0.8
)
AS
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