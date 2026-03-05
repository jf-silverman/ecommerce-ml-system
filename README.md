# ecommerce-ml-system
Base Table:
- Rows: 903,653
- Logical size: 5.37 GB
- Physical size: 112 MB
- Source: bigquery-public-data.google_analytics_sample

# proportion of sessions with transactions
-Number w/ 11552
-Number w/o 892101
-Approx 1.3% have transactions
-Need to address severe class imbalance.

# date range of data
2016-08-01 to 2017-08-01

# date split at 2016-06-01
-Gives a roughly 85% train and 15% test split

# basic logistic regression
40% precision

# base rate positive prevalence
1.46%

# model achieves X times over baseline conversion rate
27 times higher than baselinen conversion rate

