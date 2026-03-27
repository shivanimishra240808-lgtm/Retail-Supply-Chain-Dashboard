CREATE TABLE retail (
    OrderID INT,
    CustomerID VARCHAR(20),
    OrderDate DATE,
    Region VARCHAR(20),
    City VARCHAR(50),
    Category VARCHAR(50),
    Product VARCHAR(50),
    Quantity INT,
    Sales FLOAT,
    Discount FLOAT,
    Profit FLOAT
);

SELECT COUNT(*) FROM retail;
select * from retail;
# TOTAL Revneue
SELECT SUM(Sales) AS Total_Revenue
FROM retail;
# Total Profit
SELECT SUM(Profit) AS Total_Profit
FROM retail;
# Profit Margin %
SELECT 
    SUM(Profit)/SUM(Sales)*100 AS Profit_Margin_Percentage
FROM retail;

# Region-wise Sales
SELECT Region, SUM(Sales) AS Revenue
FROM retail
GROUP BY Region
ORDER BY Revenue DESC;

# Advanced SQL (CTE + Window Functions)

# Top 20% Customers (Revenue Based)
WITH customer_sales AS (
    SELECT CustomerID, SUM(Sales) AS total_sales
    FROM retail
    GROUP BY CustomerID
)
SELECT *
FROM customer_sales
ORDER BY total_sales DESC
LIMIT 20;


# Monthly Growth Rate
SELECT 
    DATE_TRUNC('month', OrderDate) AS month,
    SUM(Sales) AS monthly_sales
FROM retail
GROUP BY month
ORDER BY month;


# Rank Products by Profit (Window Function)
SELECT 
    Product,
    SUM(Profit) AS total_profit,
    RANK() OVER (ORDER BY SUM(Profit) DESC) AS profit_rank
FROM retail
GROUP BY Product;

# Loss-Making Products
SELECT Product, SUM(Profit) AS total_profit
FROM retail
GROUP BY Product
HAVING SUM(Profit) < 0;

# Discount Impact
SELECT 
    Discount,
    SUM(Profit) AS total_profit
FROM retail
GROUP BY Discount
ORDER BY Discount;

# High Performing Cities
SELECT City, SUM(Sales) AS total_sales
FROM retail
GROUP BY City
ORDER BY total_sales DESC
LIMIT 10;


SELECT COUNT(*) FROM retail;

SELECT *
FROM retail
WHERE Sales IS NULL 
   OR Profit IS NULL;

-- Business KPIs
SELECT (SUM(Sales),2) AS Total_Revenue
FROM retail;

SELECT (SUM(Profit),2) AS Total_Profit
FROM retail;

SELECT 
((SUM(Profit) * 100.0) / SUM(Sales),2) 
AS Profit_Margin_Percentage
FROM retail;

SELECT 
(SUM(Profit)/SUM(Sales)*100,2) AS Profit_Margin_Percentage
FROM retail;

--Region Performance Analysis

SELECT 
Region,
(SUM(Sales),2) AS Revenue,
(SUM(Profit),2) AS Profit
FROM retail
GROUP BY Region
ORDER BY Revenue DESC;

--Monthly Sales Trend

SELECT 
DATE_TRUNC('month', OrderDate) AS Month,
(SUM(Sales),2) AS Monthly_Sales
FROM retail
GROUP BY Month
ORDER BY Month;

--Top 10 Customers

SELECT 
CustomerID,
(SUM(Sales),2) AS Total_Sales
FROM retail
GROUP BY CustomerID
ORDER BY Total_Sales DESC
LIMIT 10;


--Loss Making Products

SELECT 
Product,
(SUM(Profit),2) AS Total_Profit
FROM retail
GROUP BY Product
HAVING SUM(Profit) < 0;


--Discount Impact Analysis

SELECT 
Discount,
(SUM(Sales),2) AS Revenue,
(SUM(Profit),2) AS Profit
FROM retail
GROUP BY Discount
ORDER BY Discount;

--Window Function (Recruiter Impress)

SELECT 
Product,
(SUM(Profit),2) AS Total_Profit,
RANK() OVER (ORDER BY SUM(Profit) DESC) AS Profit_Rank
FROM retail
GROUP BY Product;

--Top 10 Customers

SELECT 
CustomerID,
SUM(Sales) AS Total_Sales
FROM retail
GROUP BY CustomerID
ORDER BY Total_Sales DESC
LIMIT 10;

--Monthly Sales Trend

SELECT 
DATE_TRUNC('month', OrderDate) AS Month,
SUM(Sales) AS Monthly_Sales
FROM retail
GROUP BY Month
ORDER BY Month;

--Product Ranking (Window Function)

SELECT 
Product,
SUM(Profit) AS Total_Profit,
RANK() OVER (ORDER BY SUM(Profit) DESC) AS Profit_Rank
FROM retail
GROUP BY Product;

--Top 20% Customers Revenue Contribution (Pareto Analysis)

WITH customer_sales AS (
    SELECT 
        CustomerID,
        SUM(Sales) AS total_sales
    FROM retail
    GROUP BY CustomerID
),
ranked AS (
    SELECT *,
           NTILE(5) OVER (ORDER BY total_sales DESC) AS bucket
    FROM customer_sales
)
SELECT 
    bucket,
    SUM(total_sales) AS revenue
FROM ranked
GROUP BY bucket
ORDER BY bucket;

--Average Order Value (Very Important KPI)

SELECT 
SUM(Sales) / COUNT(DISTINCT OrderID) AS Avg_Order_Value
FROM retail;


--Customer Purchase Frequency

SELECT 
CustomerID,
COUNT(OrderID) AS Total_Orders
FROM retail
GROUP BY CustomerID
ORDER BY Total_Orders DESC
LIMIT 10;

--High Discount Low Profit Detection

SELECT 
Product,
AVG(Discount) AS avg_discount,
SUM(Profit) AS total_profit
FROM retail
GROUP BY Product
HAVING AVG(Discount) > 0.15
ORDER BY total_profit ASC;

--Region Wise Performance
SELECT 
Region,
SUM(Sales) AS Total_Sales,
SUM(Profit) AS Total_Profit
FROM retail
GROUP BY Region
ORDER BY Total_Sales DESC;

--Category Wise Profitability
SELECT 
Category,
SUM(Sales) AS Sales,
SUM(Profit) AS Profit,
((SUM(Profit)/SUM(Sales)) * 100,2) AS Profit_Margin
FROM retail
GROUP BY Category
ORDER BY Profit DESC;


--Monthly Sales Trend
SELECT 
DATE_TRUNC('month', OrderDate) AS Month,
SUM(Sales) AS Monthly_Sales
FROM retail
GROUP BY Month
ORDER BY Month;


--Most Profitable Products

SELECT 
Product,
SUM(Profit) AS Total_Profit
FROM retail
GROUP BY Product
ORDER BY Total_Profit DESC
LIMIT 10;

--Customer Frequency
SELECT 
CustomerID,
COUNT(DISTINCT OrderID) AS Orders_Count
FROM retail
GROUP BY CustomerID
ORDER BY Orders_Count DESC
LIMIT 10;

--Month-over-Month Growth %

WITH monthly AS (
    SELECT 
        DATE_TRUNC('month', OrderDate) AS month_date,
        SUM(Sales) AS sales
    FROM retail
    GROUP BY DATE_TRUNC('month', OrderDate)
)
SELECT 
    month_date,
    sales,
    LAG(sales) OVER (ORDER BY month_date) AS previous_month,
    (
        ((sales - LAG(sales) OVER (ORDER BY month_date))
        / NULLIF(LAG(sales) OVER (ORDER BY month_date),0)) * 100
    ,2) AS mom_growth_percentage
FROM monthly
ORDER BY month_date;


SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'retail';









