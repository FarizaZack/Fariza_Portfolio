-- A) Data Cleaning

-- Datasets : https://www.kaggle.com/datasets/rhuebner/human-resources-data-set/data

SELECT
	*
FROM
	hrdata;

-- 1) Remove Extra Characters
UPDATE 
	hrdata
SET 
	ï»¿EmployeeName = TRIM(LEADING 'ï»¿' FROM Employee_Name);

-- 2) Handle Missing Data
-- Identify Missing Column
SELECT 
    COLUMN_NAME, 
    SUM(CASE WHEN COLUMN_NAME IS NULL THEN 1 ELSE 0 END) AS missing_values
FROM 
    INFORMATION_SCHEMA.COLUMNS
WHERE 
    TABLE_NAME = 'hrdata'
GROUP BY 
    COLUMN_NAME;

-- 3) Data Formatting
-- Check for any NULL in dates
SELECT 
	DOB, 
	DateofHire, 
    DateofTermination, 
    LastPerformanceReview_Date
FROM 
	hrdata
WHERE 
    STR_TO_DATE(DOB, '%m/%d/%Y') IS NULL OR
    STR_TO_DATE(DateofHire, '%m/%d/%Y') IS NULL OR
    STR_TO_DATE(DateofTermination, '%m/%d/%Y') IS NULL OR
    STR_TO_DATE(LastPerformanceReview_Date, '%m/%d/%Y') IS NULL;
    
-- Clean Invalid Dates by adding NULL to blank cell
UPDATE 
	hrdata
SET 
    DOB = NULLIF(DOB, ''),
    DateofHire = NULLIF(DateofHire, ''),
    DateofTermination = NULLIF(DateofTermination, ''),
    LastPerformanceReview_Date = NULLIF(LastPerformanceReview_Date, '');

-- Update Date After Cleaning
UPDATE 
	hrdata 
SET 
    DOB = STR_TO_DATE(DOB, '%m/%d/%Y'),
    DateofHire = STR_TO_DATE(DateofHire, '%m/%d/%Y'),
    DateofTermination = STR_TO_DATE(DateofTermination, '%m/%d/%Y'),
    LastPerformanceReview_Date = STR_TO_DATE(LastPerformanceReview_Date, '%m/%d/%Y');
    
-- 4) Categorical Data Encoding
-- Ensure no redundancy for GenderID, MaritalStatusID, EmpStatusID
SELECT 
	DISTINCT GenderID 
FROM 
	hrdata;
    
SELECT 
	DISTINCT MaritalStatusID 
FROM 
	hrdata;
    
SELECT 
	DISTINCT MaritalStatusID 
FROM 
	hrdata;

-- 5) Check for any Duplicates
SELECT 
	EmpID, 
	COUNT(*) 
FROM 
	hrdata 
GROUP BY 
	EmpID 
HAVING 
	COUNT(*) > 1;

-- 6) Check for any Outliers & Errors
SELECT 
	* 
FROM 
	hrdata
WHERE 
	Salary < 0 
    OR Salary > 250000;  -- Adjust the threshold as necessary