# E-commerce Conversion Prediction with BigQuery ML

![BigQuery](https://img.shields.io/badge/Platform-BigQuery-blue)
![ML](https://img.shields.io/badge/Model-Boosted%20Trees-green)
![Dataset](https://img.shields.io/badge/Data-Google%20Analytics-orange)

### Key Results

- Baseline conversion rate: **1.46%**
- ROC AUC: **0.986 (Boosted Trees)**
- Top-1% conversion rate: **40.1%**
- Lift vs baseline: **27.5×**

## Overview

This project builds an end-to-end machine learning pipeline to predict whether an e-commerce session will result in a purchase.

The pipeline uses the public Google Analytics dataset in BigQuery and demonstrates a full production-style workflow including:

- Feature engineering
- Time-based train/test splitting
- Model training with BigQuery ML
- Model evaluation
- Prediction scoring
- Business lift analysis
- Simulated production scoring

The goal is to show how large-scale behavioral data can be used to prioritize high-probability customers and improve marketing efficiency.

---

## Dataset

Source dataset:
bigquery-public-data.google_analytics_sample.ga_sessions_*

The dataset contains approximately **900,000 sessions** and includes:

- Behavioral features
- Traffic acquisition information
- Device and geographic attributes
- Transaction outcomes

Example features used:

- `pageviews`
- `hits`
- `timeOnSite`
- `deviceCategory`
- `country`
- `source`
- `medium`
- `session_hour`
- `day_of_week`

Target variable:
label = 1 if transactions > 0
label = 0 otherwise

Baseline conversion rate:
1.46%

---

## Project Pipeline

The workflow implemented in this project follows a typical production ML pipeline.
```
Public GA Dataset
│
▼
sessions_clean (staging)
│
▼
session_features
│
▼
train / test split
│
▼
BigQuery ML models
├── Logistic Regression
└── Gradient Boosted Trees
│
▼
Prediction tables
│
▼
Lift analysis
│
▼
daily_predictions_gbt (simulated production scoring)

```
---

## Feature Engineering

Session-level features were created from the raw GA session data.

Key engineered features include:

- Behavioral metrics
  - `pageviews`
  - `hits`
  - `timeOnSite`
- Traffic acquisition features
  - `source`
  - `medium`
- Device and geography
  - `deviceCategory`
  - `country`
- Time-based features
  - `session_hour`
  - `day_of_week`
  - `month`
  - `is_weekend`

Feature engineering was performed entirely in **BigQuery SQL**.

---

## Train / Test Split

A **time-based split** was used to avoid leakage:

| Dataset | Date Range |
|-------|------|
| Train | Aug 2016 – May 2017 |
| Test | Jun 2017 – Aug 2017 |

This simulates a real production environment where models are trained on historical data and evaluated on future sessions.

---

## Models

Two models were trained using **BigQuery ML**.

### Logistic Regression

Used as a baseline model.

```model_type = 'logistic_reg' ```

### Gradient Boosted Trees

Improved nonlinear modeling of behavioral patterns.

```model_type = 'BOOSTED_TREE_CLASSIFIER'```

---

## Model Evaluation

Key evaluation metrics:

## Model Performance Comparison

| Metric | Logistic Regression | Gradient Boosted Trees |
|------|------|------|
| Precision | 0.4045 | **0.5196** |
| Recall | 0.1153 | **0.1965** |
| Accuracy | 0.9846 | **0.9856** |
| F1 Score | 0.1795 | **0.2852** |
| Log Loss | 0.0486 | **0.0318** |
| ROC AUC | 0.9809 | **0.9863** |


![Precision-recall and ROC curves showing model evaluation metrics. Left chart displays precision-recall by threshold with recall at 1 (blue line) declining from 100% to 0% and precision at 1 (pink line) peaking around 70% at low thresholds. Center chart shows the precision-recall curve with area under curve of 0.326, indicating the trade-off between precision and recall across different decision thresholds. Right chart displays the ROC curve with area under curve of 0.987, showing excellent discrimination between positive and negative classes with the curve rising steeply toward the top-left corner.](docs/model_evaluation/Eval%20metrics%20image.png)
Precision–recall curves and ROC curves were generated using BigQuery ML evaluation tools.

Model Improvement Takeaway: Gradient Boosted Trees improved recall by ~70% and precision by ~28% relative to logistic regression while reducing log loss and increasing AUC.

---

## Business Lift Analysis

Sessions were ranked by predicted purchase probability.

The concentration of buyers among the top-scored sessions was measured.

| Segment | Conversion Rate |
|------|------|
| Overall baseline | 1.46% |
| Top 1% predicted sessions | **40.1%** |

Lift vs baseline:

40.1% / 1.46% ≈ 27.5×

Interpretation:

Targeting the top-scored sessions improves marketing efficiency by **~27× compared with random targeting**.

---

## Prediction Pipeline

Model predictions were generated using:
ML.PREDICT()

Prediction tables include:

test_predictions
test_predictions_flat
daily_predictions_gbt

The `daily_predictions_gbt` table simulates a **production scoring pipeline**, where new sessions are scored automatically.

---

## Repository Structure
```
ecommerce-conversion-ml/
│
├── README.md
│
├── docs/
│   ├── architecture_diagram.png
│   ├── roc_curve.png
│   ├── precision_recall_curve.png
│   └── lift_curve.png
│
├── sql/
│   ├── 01_create_base_sessions.sql
│   ├── 02_create_clean_sessions.sql
│   ├── 03_class_balance.sql
│   ├── 04_create_features.sql
│   ├── 05_train_test_split.sql
│   ├── 06_train_logistic_model.sql
│   ├── 07_predict_logistic.sql
│   ├── 08_top_k_lift.sql
│   ├── 09_train_boosted_tree_model.sql
│   ├── 10_predict_boosted_tree.sql
│   └── 11_daily_scoring_pipeline.sql
│
└── notes/
├── modeling_notes.md
└── evaluation_notes.md'''

```
## Production Architecture

This project also demonstrates how the trained model could operate in a production environment using BigQuery ML.

### Batch Scoring Pipeline

1. New session data arrives in BigQuery.
2. Feature engineering transforms raw session data into the feature schema used by the model.
3. The trained model scores new sessions using `ML.PREDICT`.
4. Predictions are written to a scoring table for downstream applications.

### Example workflow:
```
New Sessions Table
│
▼
Feature Engineering (SQL)
│
▼
ML.PREDICT()
│
▼
daily_predictions_gbt
│
▼
Marketing / Personalization Systems
```
---

### Example Prediction Query

```sql
SELECT
  fullVisitorId,
  visitId,
  session_date,
  predicted_label,
  predicted_probability
FROM ML.PREDICT(
  MODEL `ml-large-scale-portfolio.ecommerce_ml.conversion_model_gbt`,
  (
    SELECT *
    FROM `ml-large-scale-portfolio.ecommerce_staging.new_sessions`
  )
);
```
Potential Production Uses

	•	Targeted marketing campaigns
	•	Real-time recommendation systems
	•	Customer prioritization for sales outreach
	•	Dynamic website personalization


## Key Takeaways

This project demonstrates how to build a scalable machine learning pipeline directly inside a cloud data warehouse.

Skills demonstrated:

- Large-scale data processing
- Feature engineering in SQL
- Time-based ML validation
- Model training using BigQuery ML
- Model evaluation and lift analysis
- Production-style prediction pipelines

---

## Future Improvements

Potential extensions include:

- Hyperparameter tuning for boosted trees
- Feature importance analysis
- Real-time scoring using Vertex AI endpoints
- Dashboard visualization of lift curves and model outputs

Possible improvements to the production pipeline include:

- Scheduled BigQuery jobs for automated daily scoring
- Feature store integration
- Real-time inference using Vertex AI endpoints
- Monitoring model drift and performance over time

