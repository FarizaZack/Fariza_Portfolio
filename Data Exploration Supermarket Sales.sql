-- Datasets : https://www.kaggle.com/code/markmedhat/sales-analysis-and-visualization/notebook

SELECT
	*
FROM
	supermarket;
    
-- B) Data Exploration 

-- 1) Average Rating by Branch
SELECT 
	Branch, 
	ROUND(AVG(Rating),1) AS Average_Rating
FROM 
	supermarket
GROUP BY 
	Branch;
    
-- Which Branch have average rating higher than overall average rating? (Using Subqueries)
SELECT 
	Branch, 
    ROUND(AVG(Rating),1) AS Branch_Average_Rating
FROM 
	supermarket
GROUP BY 
	Branch
HAVING 
	AVG(Rating) > (
				SELECT 
					AVG(Rating)
				FROM 
					supermarket
					);

-- Total Sales by Payment Method
SELECT 
	Payment, 
    ROUND(SUM(Total),2) AS Total_Sales
FROM 
	supermarket
GROUP BY 
	Payment;
    
-- Top 5 Cities by Gross Income
SELECT 
	City, 
	ROUND(SUM(gross_income),2) AS Total_Gross_Income
FROM 
	supermarket
GROUP BY 
	City
ORDER BY 
	Total_Gross_Income DESC
LIMIT 5;

-- Combine Male & Female Customer Sales in 1 Table
SELECT 
	'Male' AS Gender, 
    ROUND(SUM(Total),2) AS Total_Sales
FROM 
	supermarket
WHERE 
	Gender = 'Male'
UNION
SELECT 
	'Female', 
    ROUND(SUM(Total),2)
FROM 
	supermarket
WHERE 
	Gender = 'Female';

