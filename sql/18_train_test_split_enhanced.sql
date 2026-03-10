CREATE OR REPLACE TABLE
  `ml-large-scale-portfolio.ecommerce_ml.train_enhanced`
AS
SELECT *
FROM `ml-large-scale-portfolio.ecommerce_staging.session_features_enhanced`
WHERE session_date < DATE('2017-06-01');


CREATE OR REPLACE TABLE
  `ml-large-scale-portfolio.ecommerce_ml.test_enhanced`
AS
SELECT *
FROM `ml-large-scale-portfolio.ecommerce_staging.session_features_enhanced`
WHERE session_date >= DATE('2017-06-01');