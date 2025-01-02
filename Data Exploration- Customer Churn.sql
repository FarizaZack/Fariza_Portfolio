-- Data Exploration

-- Dataset from Kaggle : https://www.kaggle.com/datasets/saurabhbadole/bank-customer-churn-prediction-dataset/data

SELECT
	*
FROM 
	churn;

-- 1) Descriptive Stastics
SELECT 
    ROUND(AVG(CreditScore),0) AS AvgCreditScore,
    ROUND(AVG(Age),0) AS AvgAge,
    ROUND(AVG(Balance),2) AS AvgBalance,
    ROUND(AVG(EstimatedSalary),2) AS AvgSalary,
    SUM(Exited) AS TotalExited
FROM 
	churn;

-- 2) Customer Churn Rate

SELECT 
    round((SUM(Exited)/COUNT(CustomerId))*100,2) AS ChurnRate
FROM 
	churn;
    
-- 3) Geogprahical Distribution
-- To know how many customers exit
SELECT 
	Geography, 
    COUNT(*) AS TotalCustomers, 
    SUM(Exited) AS ChurnedCustomers
FROM 
	churn
GROUP BY 
	Geography
ORDER BY 
	TotalCustomers DESC;
    
-- 4) Gender Wise Churn
-- 
SELECT 
	Gender, 
	COUNT(*) AS TotalCustomers, 
    SUM(Exited) AS ChurnedCustomers
FROM 
	churn
GROUP BY 
	Gender;

-- 5) Age vs Churn
SELECT 
	Age, 
	COUNT(*) AS TotalCustomers, 
	SUM(Exited) AS ChurnedCustomers
FROM 
	churn
GROUP BY 
	Age
ORDER BY 
	Age;
    
-- 6) Correlation Between Products and Churn
SELECT 
	NumOfProducts, 
	COUNT(*) AS TotalCustomers, 
	SUM(Exited) AS ChurnedCustomers
FROM 
	churn
GROUP BY 
	NumOfProducts;
    
-- 7) Active Members and Churn
SELECT 
	IsActiveMember, 
    COUNT(*) AS TotalCustomers, 
    SUM(Exited) AS ChurnedCustomers
FROM 
	churn
GROUP BY 
	IsActiveMember;




