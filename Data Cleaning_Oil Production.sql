-- DATA CLEANING

-- Dataset from Kaggle : https://www.kaggle.com/datasets/sazidthe1/oil-production?resource=download

SELECT
	*
FROM
	oil;

-- 1) Remove Duplicates
-- Check for any duplicate
SELECT 
	* 
FROM 
	oil
WHERE country_name IS NULL 
   OR type IS NULL
   OR product IS NULL
   OR flow IS NULL
   OR year IS NULL
   OR value IS NULL;

-- 2) Standardize formatting to uppercase
UPDATE oil
SET country_name = TRIM(UPPER(country_name)),
    type = TRIM(UPPER(type)),
    product = TRIM(UPPER(product)),
    flow = TRIM(UPPER(flow));
    
-- 3) Check for any outliers
SELECT 
	country_name, 
    type, 
    product, 
    year, 
    value
FROM 
	oil
WHERE 
	value < 0 
    OR value > (SELECT AVG(value) * 3 
				FROM oil);

-- Understand the outliers
SELECT 
    CASE 
        WHEN value < 0 THEN 'Negative Values'
        WHEN value > (SELECT AVG(value) * 3 FROM oil) THEN 'High Outliers'
    END AS outlier_type,
    COUNT(*) AS count,
    MIN(value) AS min_value,
    MAX(value) AS max_value
FROM 
	oil
WHERE 
	value < 0 
   OR value > (SELECT AVG(value) * 3 FROM oil)
GROUP BY 
	outlier_type;

-- Negative Values
-- logically, in oil production values have no -ve values bcus production is physical qty & cannot hv less than 0. so could be data entry error. So remove the negative values.
-- Create new table to remove -ve and 0 values
CREATE TABLE oil_cleaned AS
SELECT 
	*
FROM 
	oil
WHERE 
	value > 0;
  
SELECT
	*
FROM 
	oil_cleaned;
