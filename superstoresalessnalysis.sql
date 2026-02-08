/* ============================================================
   SUPERSTORE SALES & PROFIT ANALYSIS
   ============================================================ */

/* ------------------------------------------------------------
   1. DATA OVERVIEW
   ------------------------------------------------------------ */

-- Total number of rows
SELECT 
    COUNT(*) AS count_rows
FROM superstore_sales;


/* ------------------------------------------------------------
   2. CORE KPIs
   ------------------------------------------------------------ */

-- Total Sales
SELECT 
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM superstore_sales;

-- Total Profit
SELECT 
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM superstore_sales;

-- Profit Margin Percentage
SELECT 
    ROUND(SUM(Profit) / SUM(Sales) * 100, 2) AS Profit_Margin_Percentage
FROM superstore_sales;

-- Total Orders
SELECT 
    COUNT(DISTINCT Order_ID) AS Total_Orders
FROM superstore_sales;

-- Average Order Value
SELECT 
    ROUND(SUM(Sales) / COUNT(DISTINCT Order_ID), 2) AS Average_Order_Value
FROM superstore_sales;


/* ------------------------------------------------------------
   3. CATEGORY & SUB-CATEGORY ANALYSIS
   ------------------------------------------------------------ */

-- Sales & Profit by Category
SELECT 
    Category,
    ROUND(SUM(Sales), 2)  AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM superstore_sales
GROUP BY Category
ORDER BY Total_Sales DESC;

-- Rename Sub-Category column (one-time cleanup)
ALTER TABLE superstore_sales
RENAME COLUMN `Sub-Category` TO Sub_Category;

-- Sales & Profit by Sub-Category
SELECT 
    Sub_Category,
    ROUND(SUM(Sales), 2)  AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM superstore_sales
GROUP BY Sub_Category
ORDER BY Total_Sales ASC;


/* ------------------------------------------------------------
   4. REGIONAL & SEGMENT ANALYSIS
   ------------------------------------------------------------ */

-- Sales & Profit by Region
SELECT 
    Region,
    ROUND(SUM(Sales), 2)  AS Sales,
    ROUND(SUM(Profit), 2) AS Profit
FROM superstore_sales
GROUP BY Region
ORDER BY Profit DESC;

-- Sales & Profit by Customer Segment
SELECT 
    Segment,
    ROUND(SUM(Sales), 2)  AS Sales,
    ROUND(SUM(Profit), 2) AS Profit
FROM superstore_sales
GROUP BY Segment;


/* ------------------------------------------------------------
   5. TIME-BASED ANALYSIS
   ------------------------------------------------------------ */

-- Yearly Sales & Profit Trend
SELECT 
    YEAR(Order_Date) AS Year,
    ROUND(SUM(Sales), 2)  AS Sales,
    ROUND(SUM(Profit), 2) AS Profit
FROM superstore_sales
GROUP BY Year
ORDER BY Year;

-- Monthly Sales Trend
SELECT 
    MONTH,
    ROUND(SUM(Sales), 2) AS Sales
FROM superstore_sales
GROUP BY Month
ORDER BY Month;


/* ------------------------------------------------------------
   6. DISCOUNT IMPACT ANALYSIS
   ------------------------------------------------------------ */

-- Sales & Profit by Discount Level
SELECT 
    Discount,
    ROUND(SUM(Sales), 2)  AS Sales,
    ROUND(SUM(Profit), 2) AS Profit
FROM superstore_sales
GROUP BY Discount
ORDER BY Discount;


/* ------------------------------------------------------------
   7. TOP PERFORMERS ANALYSIS
   ------------------------------------------------------------ */

-- Top 10 Customers by Sales
SELECT 
    Customer_Name,
    ROUND(SUM(Sales), 2) AS Sales
FROM superstore_sales
GROUP BY Customer_Name
ORDER BY Sales DESC
LIMIT 10;


/* ------------------------------------------------------------
   8. DATA QUALITY & LOSS ANALYSIS
   ------------------------------------------------------------ */

-- Check for null values
SELECT *
FROM superstore_sales
WHERE Sales IS NULL 
   OR Profit IS NULL;

-- Count of loss-making orders
SELECT 
    COUNT(*) AS Loss_Orders
FROM superstore_sales
WHERE Profit < 0;

-- Loss-making states
SELECT 
    State,
    ROUND(SUM(Profit), 2) AS Profit
FROM superstore_sales
GROUP BY State
HAVING Profit < 0
ORDER BY Profit;


/* ------------------------------------------------------------
   9. SHIPPING MODE ANALYSIS
   ------------------------------------------------------------ */

-- Sales & Profit by Ship Mode
SELECT 
    Ship_Mode,
    ROUND(SUM(Sales), 2)  AS Sales,
    ROUND(SUM(Profit), 2) AS Profit
FROM superstore_sales
GROUP BY Ship_Mode;
