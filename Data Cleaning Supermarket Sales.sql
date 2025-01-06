-- Datasets : https://www.kaggle.com/code/markmedhat/sales-analysis-and-visualization/notebook

SELECT
	*
FROM
	supermarket;

-- A) Data Cleaning

-- 1) Any Missing Values ?
SELECT 
	* 
FROM 
	supermarket
WHERE 
	Invoice_ID IS NULL 
   OR Branch IS NULL 
   OR City IS NULL 
   OR Customer_type IS NULL 
   OR Gender IS NULL 
   OR Product_line IS NULL 
   OR Unit_price IS NULL 
   OR Quantity IS NULL 
   OR `Tax_5%` IS NULL  -- %, Data, Time special characters in MYSQL so require backtick `
   OR Total IS NULL 
   OR `Date` IS NULL 
   OR `Time` IS NULL 
   OR Payment IS NULL 
   OR cogs IS NULL 
   OR gross_margin_percentage IS NULL 
   OR gross_income IS NULL 
   OR Rating IS NULL;

-- 2) Any Duplicates, Remove by CTE (Common Table Expression)
WITH DuplicateIDs AS (
    SELECT 
		Invoice_ID
    FROM 
		supermarket
    GROUP BY 
		Invoice_ID
    HAVING 
		COUNT(*) > 1
)
DELETE FROM 
	supermarket
WHERE 
	Invoice_ID IN (
					SELECT 
						Invoice_ID 
					FROM 
						DuplicateIDs);

-- 3) Data Consistency
-- To check if Total = COGS + Tax_5%
SELECT 
	Invoice_ID, 
	ROUND(Total,2), 
    ROUND((cogs + `Tax_5%`),2) AS Calculated_Total
FROM 
	supermarket
WHERE 
	Total != (cogs + `Tax_5%`);
    
