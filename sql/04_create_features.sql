CREATE OR REPLACE TABLE
  `ml-large-scale-portfolio.ecommerce_staging.session_features`
AS
SELECT
  -- identifiers
  fullVisitorId,
  visitId,
  session_date,

  -- label (target variable)
  IF(transactions > 0, 1, 0) AS label,

  -- behavioral features
  pageviews,
  hits,
  timeOnSite,

  -- acquisition features
  source,
  medium,

  -- device / geo
  deviceCategory,
  country,

  -- time features (very useful predictors)
  EXTRACT(DAYOFWEEK FROM session_date) AS day_of_week,
  EXTRACT(MONTH FROM session_date) AS month

FROM `ml-large-scale-portfolio.ecommerce_staging.sessions_clean`;