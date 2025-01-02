-- A) Data Cleaning

-- Dataset from Kaggle : https://www.kaggle.com/datasets/saurabhbadole/bank-customer-churn-prediction-dataset/data

SELECT
	*
FROM 
	churn;

-- 1) Check for duplicates
SELECT 
	CustomerId, 
    COUNT(*)
FROM 
	churn
GROUP BY 
	CustomerId
HAVING 
	COUNT(*) > 1;

-- 2) Handle Missing Values
-- Are there any NULL ?
SELECT 
	*
FROM 
	churn
WHERE 
	CreditScore IS NULL 
    OR Geography IS NULL 
    OR Gender IS NULL;
    
-- 3) Standardize Gender Field
UPDATE 
	churn
SET 
	Gender = UPPER(Gender)
WHERE 
	Gender NOT IN ('MALE', 'FEMALE');