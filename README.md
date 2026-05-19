## streaming-analytics-sql-project
<img width="1883" height="835" alt="ChatGPT Image May 8, 2026, 12_01_14 AM" src="https://github.com/user-attachments/assets/6feed241-14f5-4514-ad23-fbb4912d4212" />

# Project Overview
A complete SQL-based Business Intelligence & Data Analytics project that simulates how real OTT platforms like Netflix and Disney+ Hotstar analyze user behavior, engagement, subscriptions, and revenue using data. This project is a real-world OTT Streaming Platform Analytics System built using MySQL.

The system analyzes:

* User behavior
* Content engagement
* Subscription trends
* Revenue performance
* Churn & retention
* Business KPIs

using SQL queries and business intelligence techniques.

The project demonstrates how raw streaming platform data can be transformed into actionable business insights.

---

# Business Problem

OTT platforms generate massive amounts of data every day:

* User watch activity
* Ratings & reviews
* Subscription purchases
* Revenue transactions
* Engagement metrics

Without analytics, companies cannot answer important business questions like:

* Which genre keeps users engaged?
* Which users are likely to churn?
* Which subscription plan generates highest revenue?
* Which content performs best?
* How can engagement and retention be improved?

This project solves these problems using SQL-based analytics.

---

# Real-World Scenario

This project simulates the workflow of modern OTT companies.

```text id="ybjlwm"
Users Watch Content
        ↓
Platform Stores Data
        ↓
Database Collects User Activity
        ↓
SQL Analysis Performed
        ↓
KPIs & Insights Generated
        ↓
Business Decisions Taken
```

---

# Database Schema

The project contains 5 relational tables:

| Table             | Description                      |
| ----------------- | -------------------------------- |
| Users             | User demographic information     |
| Content           | Movies & Series metadata         |
| UserEngagement    | Watch activity, ratings, reviews |
| Subscriptions     | Subscription plans               |
| UserSubscriptions | User subscription lifecycle      |

---

# Tech Stack

| Technology         | Usage                   |
| ------------------ | ----------------------- |
| MySQL              | Database Management     |
| SQL                | Data Analysis           |
| GitHub             | Project Hosting         |

---

# Data Cleaning

Performed data cleaning to improve data quality:

* Removed invalid watch durations
* Checked duplicate engagement records
* Validated ratings
* Verified subscription status values
* Handled inconsistent records

---

# Exploratory Data Analysis (EDA)

Performed exploratory analysis on:

* Total users
* Watch events
* User activity
* Content distribution
* Subscription trends
* Revenue patterns

---

# Analysis Performed

## 👤 User Analysis

* Active users
* Monthly Active Users (MAU)
* Daily Active Users (DAU)
* Binge-watchers
* Churn-risk users

---

## Content Analysis

* Most watched content
* Top-rated content
* Genre popularity
* Language analysis
* Engagement by genre

---

## Subscription Analysis

* Revenue by plan
* Active vs expired subscriptions
* ARPU analysis
* Retention & churn analysis

---

## KPI Analysis

* Total Revenue
* Average Watch Time
* Engagement Rate
* Retention Rate
* Churn Rate
* ARPU
* MAU & DAU

---

# Key Insights

✅ Action genre drives highest engagement
✅ Premium 4K generates maximum revenue
✅ Indian users contribute majority of traffic
✅ Higher watch duration leads to better ratings
✅ Inactive users show high churn probability
✅ Premium users are highly engaged

---

# Business Recommendations

* Invest more in Action & Thriller content
* Promote Premium 4K plans aggressively
* Improve personalized recommendations
* Send re-engagement campaigns to inactive users
* Expand regional-language content
* Highlight top-rated content on homepage

---

# Project Structure

```text id="4u8ywx"
streaming-platform-data-analysis/
│
├── database/
│   ├── schema.sql
│   └── sample_data.sql
│
├── analysis/
│   ├── business_questions.md
│   ├── data_cleaning.sql
│   ├── kpi_analysis.sql
│   ├── analysis_queries.sql
│   └── insights.md
│
├── assets/
│   ├── ai_generated_dashboard.png
│   ├── er_diagram.png
│   └── project_banner.png
│
├── README.md
└── LICENSE
```

---

# Future Improvements

* Recommendation System
* Predictive Churn Modeling
* Cohort Retention Analysis
* Power BI Executive Dashboard
* Python/Pandas Analytics Layer
* Full Stack OTT Integration

---

# Skills Demonstrated

* SQL Joins & Aggregations
* KPI Analysis
* Data Cleaning
* Business Intelligence
* User Behavior Analytics
* Revenue Analytics
* Churn & Retention Analysis
* Data-Driven Decision Making

---

# Conclusion

This project demonstrates how SQL can be used to solve real-world business problems in the OTT streaming industry.

By analyzing user engagement, subscription behavior, content performance, and platform KPIs, the system helps generate actionable insights that improve:

* User retention
* Customer engagement
* Revenue growth
* Content strategy

This project closely simulates real-world OTT analytics workflows used in modern streaming companies.

---
