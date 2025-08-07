use market1;
rename tables scarce_items_analysis to mark_int;
show tables;

set sql_safe_updates = 0;
set sql_safe_updates = 1;

-- Tagging Scarce Items

UPDATE mark_int
SET Is_Scarce = CASE
    WHEN Stock_Level < Demand * 0.5 THEN 1 ELSE 0
END;

UPDATE mark_int
SET Potentially_Scarce = CASE
    WHEN Supply / Demand < 0.7 OR Supply / Demand > 1.5 THEN 1 ELSE 0
END;

-- Calculate Net Loss
UPDATE mark_int
SET Net_Loss = Dispute_Amount - Win_Amount - Recouped_Amount;

-- Flag Spike Indicator
UPDATE mark_int
SET Spike_Indicator = CASE
    WHEN Net_Loss > 700 THEN 1 ELSE 0
END;

-- Conversion & Experience Insights
SELECT Category, Region, AVG(Conversion_Rate) AS AvgConversion, AVG(Experience_Score) AS AvgExperience
FROM mark_int
GROUP BY Category, Region;

-- Insights & Summary Queries
 -- Top 5 scarce categories:

SELECT Category, COUNT(*) AS ScarceCount
FROM mark_int
WHERE Is_Scarce = 1
GROUP BY Category
ORDER BY ScarceCount DESC
LIMIT 5;

-- Regions with highest net loss:
SELECT Region, SUM(Net_Loss) AS TotalLoss
FROM mark_int
GROUP BY Region
ORDER BY TotalLoss DESC;

-- Items with Spike:
SELECT Item_ID, Category, Net_Loss
FROM mark_int
WHERE Spike_Indicator = 1
ORDER BY Net_Loss DESC;

-- Identify Scarce Items
SELECT *
FROM mark_int
WHERE Stock_Level < Demand * 0.5;

-- Flag Potentially Scarce Items (Volatile supply-demand ratio)
SELECT *
FROM mark_int
WHERE (Demand / Supply) < 0.75 OR (Demand / Supply) > 1.25;

-- Calculate Net Loss for All Items
SELECT Item_ID, 
       Dispute_Amount, 
       Win_Amount, 
       Recouped_Amount,
       (Dispute_Amount - Win_Amount - Recouped_Amount) AS Net_Loss
FROM mark_int;

-- Find Items with High Net Loss (Spike Indicator)
SELECT *
FROM mark_int
WHERE (Dispute_Amount - Win_Amount - Recouped_Amount) > 700;

-- Top Items by Conversion Rate (for Promotion Focus)
SELECT Item_ID, Category, Region, Conversion_Rate
FROM mark_int
ORDER BY Conversion_Rate DESC
LIMIT 10;

-- Region-Wise Scarcity Behavior (for heatmap)
SELECT Region, 
       COUNT(*) AS Total_Items,
       SUM(CASE WHEN Is_Scarce = 'Yes' THEN 1 ELSE 0 END) AS Scarce_Items
FROM mark_int
GROUP BY Region;

-- Average Experience Score by Region
SELECT Region, 
       ROUND(AVG(Experience_Score), 2) AS Avg_Experience_Score
FROM mark_int
GROUP BY Region;

-- Net Loss Summary by Category
SELECT Category,
       SUM(Dispute_Amount) AS Total_Dispute,
       SUM(Win_Amount) AS Total_Win,
       SUM(Recouped_Amount) AS Total_Recouped,
       SUM(Net_Loss) AS Total_Net_Loss
FROM mark_int
GROUP BY Category;

-- Spike Items with Low Experience (for critical focus)
SELECT *
FROM mark_int
WHERE Spike_Indicator = 'Yes'
  AND Experience_Score < 10;

-- Conversion Rate vs. Experience Score (Correlation trend)
SELECT Conversion_Rate, Experience_Score
FROM mark_int;

-- Advanced queries
-- Monthly Net Loss Trend per Region
SELECT 
    Region,
    DATE_FORMAT(Date, '%Y-%m') AS Month,
    SUM(Net_Loss) AS Total_Net_Loss
FROM mark_int
GROUP BY Region, DATE_FORMAT(Date, '%Y-%m')
ORDER BY Region, Month;

-- Top 5 Categories with Highest Average Spike Loss
SELECT 
    Category,
    ROUND(AVG(Net_Loss), 2) AS Avg_Net_Loss
FROM mark_int
WHERE Spike_Indicator = 1
AND Net_Loss IS NOT NULL
GROUP BY Category
ORDER BY Avg_Net_Loss DESC
LIMIT 5;

-- Items with High Conversion But Low Experience
SELECT Item_ID, Category, Region, Conversion_Rate, Experience_Score
FROM mark_int
WHERE Conversion_Rate > 0.7 AND Experience_Score < 3
ORDER BY Conversion_Rate DESC;

-- Scarce Items Recovery Efficiency
SELECT 
    Item_ID,
    Dispute_Amount,
    (Win_Amount + Recouped_Amount) AS Total_Recovery,
    ROUND(((Win_Amount + Recouped_Amount) / Dispute_Amount) * 100, 2) AS Recovery_Percentage
FROM mark_int
WHERE Is_Scarce = 1
  AND Dispute_Amount > 0;

-- Spike Pattern per Region with Item Count
SELECT 
    Region,
    COUNT(*) AS Total_Items,
    SUM(CASE WHEN Spike_Indicator = 'Yes' THEN 1 ELSE 0 END) AS Spike_Items,
    ROUND((SUM(CASE WHEN Spike_Indicator = 'Yes' THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2) AS Spike_Rate_Percent
FROM mark_int
GROUP BY Region
ORDER BY Spike_Rate_Percent DESC;





