-- Data Cleaning

-- Dataset from Kaggle : https://www.kaggle.com/datasets/mirichoi0218/insurance

SELECT
	*
FROM
	medical_insurance;
        
-- 1) Remove Duplicates
SELECT 
	*, 
    COUNT(*) 
FROM 
	medical_insurance
GROUP BY 
	age, sex, bmi, children, smoker, region, charges 
HAVING 
	COUNT(*) > 1; -- HAVING & GROUP BY usually applied together. HAVING COUNT so that it keep is there is greater than one to show any duplicates

-- 2) Handle Missing Values
-- If there is any NULL values?
SELECT 
	* 
FROM 
	medical_insurance
WHERE 
	age IS NULL 
    OR sex IS NULL 
    OR bmi IS NULL 
    OR children IS NULL 
    OR smoker IS NULL 
    OR region IS NULL 
    OR charges IS NULL;

-- 3) Validate Data Types
ALTER TABLE medical_insurance
MODIFY age INT,
MODIFY bmi DECIMAL(10,2), 
MODIFY children DECIMAL(10,2),
MODIFY charges DECIMAL(10,2);


-- 4) Check for Outliers
SELECT 
	* 
FROM 
	medical_insurance
WHERE 
	bmi > 40 
    OR bmi < 15;

-- 5) Standardize Categorical Data
SELECT 
	DISTINCT sex, smoker, region 
FROM 
	medical_insurance;

-- 6) Normalize Case
UPDATE 
	medical_insurance 
SET 
	sex = LOWER(sex), 
    smoker = LOWER(smoker), 
    region = LOWER(region);

