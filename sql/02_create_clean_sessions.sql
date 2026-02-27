CREATE TABLE `ml-large-scale-portfolio.ecommerce_staging.sessions_clean` AS
SELECT
  fullVisitorId,
  visitId,
  visitStartTime,
  PARSE_DATE('%Y%m%d', date) AS session_date,
  device.deviceCategory as deviceCategory,
  geoNetwork.country as country,
  trafficSource.source as source,
  trafficSource.medium as medium,
  totals.pageviews as pageviews,
  totals.hits as hits,
  totals.timeOnSite as timeOnSite,
  totals.transactions as transactions,
  totals.transactionRevenue as transactionRevenue,
  totals.newVisits as newVisits
FROM `ml-large-scale-portfolio.ecommerce_raw.sessions`;