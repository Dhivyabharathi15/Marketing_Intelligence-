**Marketing Intelligence Dashboard: Scarcity, Conversion & Net Loss Insights**

**Project Overview**
This project aims to monitor and analyze trends in demand, supply, conversion rate, and customer experience for items marked as scarce or potentially scarce. By leveraging MySQL for data processing and Power BI for visualization, the project provides insights to help business teams reduce chargebacks, manage inventory better, and boost recovery efficiency.

**Table of Contents**

Introduction

Techniques and Tools Used

Key Insights

SQL Queries Used

Data Sources

**Introduction**
In fast-moving product categories, poor inventory forecasting and unresolved chargebacks can result in high net losses. This project uses MySQL queries to tag scarce items, detect spikes, and track recovery performance. The goal is to help business units respond to shortages, improve customer satisfaction, and minimize financial losses.

**Techniques and Tools Used**

SQL (MySQL Workbench): Scarcity logic, tagging, and KPI calculation

Power BI: Data visualization (scarcity rate, net loss, experience score)

CSV Dataset: 10,000 cleaned records with item, region, and performance metrics

**Key Insights**

Scarcity Detection: Items with stock level < 50% of demand were marked scarce.

Potential Volatility: Items with fluctuating supply-demand ratios were flagged as potentially scarce.

Spike Indicators: Transactions with Net Loss > $700 were marked as spikes.

Recovery Efficiency: Calculated using Win Amount and Recouped Amount vs. Dispute Amount.

Conversion vs Experience: Some high-converting items had poor experience scores, affecting long-term loyalty.

**Data Sources**

The cleaned dataset includes the following columns:

Item_ID, Category, Region, Date, Stock_Level, Demand, Supply, Is_Scarce, Potentially_Scarce, Conversion_Rate, Experience_Score, Dispute_Amount, Win_Amount, Recouped_Amount, Tag_Status, Net_Loss, Spike_Indicator

**Conclusion**

This project shows how SQL can be used to automate inventory flagging, financial loss tracking, and customer behavior analysis. With scarcity tagging, net loss insights, and regional trends, the business can make proactive decisions that improve supply efficiency and customer satisfaction.

Next steps may include integrating ML models to predict future spikes or implementing real-time triggers for stock alerts.
