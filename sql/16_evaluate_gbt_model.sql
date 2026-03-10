SELECT *
FROM ML.EVALUATE(
  MODEL `ml-large-scale-portfolio.ecommerce_ml.conversion_model_gbt`,
  (
    SELECT *
    FROM `ml-large-scale-portfolio.ecommerce_ml.test`
  )
);