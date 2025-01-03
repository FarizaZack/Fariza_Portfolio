-- Data Exploration
-- Dataset from Kaggle : https://www.kaggle.com/datasets/mirichoi0218/insurance

SELECT 
	*
FROM
	insurance_deduplicated;


-- 1) Summary Statitics
SELECT 
    ROUND(AVG(bmi),2) AS avg_bmi, 
	ROUND(AVG(charges),2) AS avg_charges,    
	ROUND(AVG(age),0) AS avg_age,    
    MAX(bmi) AS max_bmi, 
	MAX(charges) AS max_charges, 
	MAX(age) AS max_age,
    MIN(bmi) AS min_bmi,
    MIN(charges) AS min_charges,
	MIN(age) AS min_age 
FROM 
	insurance_deduplicated;

-- 2) Count the frequency in categorical values such as sex, smoker, region
-- # Frequency of Sex
SELECT 
	sex,
     COUNT(*) AS count 
FROM 
	insurance_deduplicated
GROUP BY 
	sex;

-- # Frequency of Smoker
SELECT 
    smoker, 
    COUNT(*) AS count
FROM 
	insurance_deduplicated
GROUP BY 
    smoker;

-- # Frequency of Region
SELECT 
    region, 
    COUNT(*) AS count
FROM 
	insurance_deduplicated
GROUP BY 
    region;

-- 3) Correlations
-- The higher ratio gives higher medical charges related to age
-- The lower ratio gives low medical charges compare to age

-- Any relation between Age and Charges ?
SELECT 
    age, 
    ROUND(AVG(charges),2) AS avg_charges
FROM 
	insurance_deduplicated
GROUP BY 
    age
ORDER BY 
    age;
    
-- Any relation between BMI and Charges ?
SELECT 
    bmi, 
    ROUND(AVG(charges),2) AS avg_charges
FROM 
	insurance_deduplicated
GROUP BY 
    bmi
ORDER BY 
    bmi;
    
-- 4) Group Analysis
-- Grouping by region
SELECT 
    region, 
    ROUND(AVG(charges), 2) AS avg_charges 
FROM 
    insurance_deduplicated
GROUP BY 
    region;

-- 5) Detect Patterns
SELECT 
	age, 
    ROUND(AVG(charges), 2) AS avg_charges 
FROM 
	insurance_deduplicated
GROUP BY 
	age 
ORDER BY 
	age;
    
-- 6) Create Bins
-- Bins by Age Group
SELECT 
    CASE 
        WHEN age BETWEEN 18 AND 25 THEN '18-25' 
        WHEN age BETWEEN 26 AND 35 THEN '26-35' 
        WHEN age BETWEEN 36 AND 45 THEN '36-45' 
        ELSE '46+' 
    END AS age_group, 
    ROUND(AVG(charges), 2) AS avg_charges 
FROM 
	insurance_deduplicated
GROUP BY 
	age_group;

-- 7) Regional Analysis
-- Compare by BMI & Charges
SELECT 
	region,
    ROUND(AVG(bmi),2) AS avg_bmi, 
    ROUND(AVG(charges), 2) AS avg_charges 
FROM 
	insurance_deduplicated
GROUP BY 
	region;
    
-- 8) Relationship Exploration
-- Relation between smoker status & charges

SELECT 
	smoker, 
	ROUND(AVG(charges),2) AS avg_charges 
FROM 
	insurance_deduplicated
GROUP BY 
	smoker;




