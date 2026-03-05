CREATE OR REPLACE TABLE
  `ml-large-scale-portfolio.ecommerce_ml.train`
AS
SELECT *
FROM `ml-large-scale-portfolio.ecommerce_staging.session_features`
WHERE session_date < DATE('2017-06-01');

CREATE OR REPLACE TABLE
  `ml-large-scale-portfolio.ecommerce_ml.test`
AS
SELECT *
FROM `ml-large-scale-portfolio.ecommerce_staging.session_features`
WHERE session_date >= DATE('2017-06-01');