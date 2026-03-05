SELECT *
FROM ML.EVALUATE(
  MODEL `ml-large-scale-portfolio.ecommerce_ml.conversion_model`,
  (
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
    FROM `ml-large-scale-portfolio.ecommerce_ml.test`
  )
);