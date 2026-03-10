CREATE TABLE `ml-large-scale-portfolio.ecommerce_staging.session_features_enhanced`
AS
SELECT
  sf.*, EXTRACT(HOUR FROM TIMESTAMP_SECONDS(sc.visitStartTime)) AS session_hour
FROM `ml-large-scale-portfolio.ecommerce_staging.session_features` AS sf
INNER JOIN `ml-large-scale-portfolio.ecommerce_staging.sessions_clean` AS sc
  ON
    sf.fullVisitorId = sc.fullVisitorId
    AND sf.visitId = sc.visitId
    AND sf.session_date = sc.session_date;
