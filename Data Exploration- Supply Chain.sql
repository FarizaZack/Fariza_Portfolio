SELECT
	*
FROM
	supply_chain;
    
-- Dataset from Kaggle : https://www.kaggle.com/code/ainurrohmanbwx/supply-chain-analytics-modeling-lightgbm-rnn/notebook
  
-- Data Exploration

-- 1) Summary Statistics
-- Revenue generated?
SELECT 
	ROUND(SUM(revenue_generated),2) AS total_revenue 
FROM 
	supply_chain;
    
-- Average Stock levels?
SELECT 
	round(AVG(stock_levels),0) AS avg_stock_levels 
FROM 
	supply_chain;

-- 2) Top Performing Products
SELECT 
	product_type, 
	ROUND(SUM(revenue_generated),2) AS total_revenue
FROM 
	supply_chain
GROUP BY 
	product_type
ORDER BY 
	total_revenue DESC
LIMIT 5;

-- 3) Analyse Lead Times
SELECT 
	supplier_name, 
    ROUND(AVG(lead_times),0) AS avg_lead_time
FROM 
	supply_chain
GROUP BY 
	supplier_name
ORDER BY 
	avg_lead_time ASC;

-- 4) Check Defect Rates
SELECT 
	product_type, 
    ROUND(AVG(defect_rates),2) AS avg_defect_rate
FROM 
	supply_chain
GROUP BY 
	product_type
HAVING 
	avg_defect_rate > 0.05;


-- 5) Customer Demographics Insights
SELECT 
	customer_demographics, 
	COUNT(*) AS customer_count
FROM 
	supply_chain
GROUP BY 
	customer_demographics
ORDER BY 
	customer_count DESC;