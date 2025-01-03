-- Data Cleaning

-- Dataset from Kaggle : https://www.kaggle.com/datasets/mirichoi0218/insurance

SELECT
	*
FROM
	medical_insurance
ORDER BY
	age;
        
-- 1) Remove Duplicates
-- Check for any duplicate

SELECT 
	*, 
    COUNT(*) 
FROM 
	medical_insurance
GROUP BY 
	age, sex, bmi, children, smoker, region, charges 
HAVING 
	COUNT(*) > 1; -- HAVING & GROUP BY usually applied together. HAVING COUNT so that it keep is there is greater than one to show any duplicates

-- Create New Table & Using DISTINCT 
CREATE TABLE 
	insurance_deduplicated AS
SELECT 
	DISTINCT age, sex, bmi, children, smoker, region, charges
FROM 
	medical_insurance;

-- New Table
SELECT 
	*
FROM
	insurance_deduplicated;
    
-- 2) Handle Missing Values
-- If there is any NULL values?
SELECT 
	* 
FROM
	insurance_deduplicated
WHERE 
	age IS NULL 
    OR sex IS NULL 
    OR bmi IS NULL 
    OR children IS NULL 
    OR smoker IS NULL 
    OR region IS NULL 
    OR charges IS NULL;

-- 3) Validate Data Types
ALTER TABLE insurance_deduplicated
MODIFY age INT,
MODIFY bmi DECIMAL(10,2), 
MODIFY children DECIMAL(10,2),
MODIFY charges DECIMAL(10,2);

-- 4) Check for Outliers
SELECT 
	* 
FROM 
	insurance_deduplicated
WHERE 
	bmi > 40 
    OR bmi < 15
ORDER BY
		bmi;

-- 5) Standardize Categorical Data
SELECT 
	DISTINCT sex, smoker, region 
FROM 
	insurance_deduplicated;

-- 6) Normalize Case
UPDATE 
	insurance_deduplicated
SET 
	sex = LOWER(sex), 
    smoker = LOWER(smoker), 
    region = LOWER(region);
