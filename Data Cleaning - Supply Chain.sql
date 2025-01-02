-- Data Cleaning

-- Dataset from Kaggle : https://www.kaggle.com/code/ainurrohmanbwx/supply-chain-analytics-modeling-lightgbm-rnn/notebook

SELECT
	*
FROM
	supply_chain;

-- 1) Missing Values
SELECT 
	COUNT(*) AS null_count
FROM
	supply_chain
WHERE 
	Price IS NULL
   OR Availability IS NULL
   OR number_of_product_Sold IS NULL
   OR Revenue_generated IS NULL
   OR Customer_demographics IS NULL;


-- 2) Duplicate Records
SELECT 
	sku, 
    COUNT(*) AS record_count
FROM
	supply_chain
GROUP BY 
	sku
HAVING 
	COUNT(*) > 1;

-- 3) Data Types
-- To ensure all values in Price in numerical values
SELECT 
	sku, 
    ROUND(price,2) AS Price2
FROM
	supply_chain
WHERE NOT 
	price REGEXP '^[0-9]+(\\.[0-9]{1,2})?$';

-- 4) Standardize Formats
-- To change uppercase for location
UPDATE 
	supply_chain
SET 
	location = UPPER(location);

-- 5) Change numberical values decimal places
UPDATE 
	supply_chain
SET
    Price = ROUND(Price, 2),
    Revenue_generated = ROUND(Revenue_generated, 2),
    Shipping_cost = ROUND(Shipping_cost, 2),
    Manufacturing_cost = ROUND(Manufacturing_cost, 2),
    Defect_rates = ROUND(Defect_rates,2),
    Costs = ROUND(Costs, 2);

