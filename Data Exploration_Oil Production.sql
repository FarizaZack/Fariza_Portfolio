-- DATA EXPLORATORY ANALYSIS

-- Dataset from Kaggle : https://www.kaggle.com/datasets/sazidthe1/oil-production?resource=download

SELECT
	*
FROM 
	oil_cleaned;
    
-- 1) What is the Total Oil Production by Year ?
SELECT 
	year, 
    ROUND(SUM(value), 2) AS total_production 
FROM 
	oil_cleaned
GROUP BY 
	year
ORDER BY 
	year;

-- 2) Which are the Top 5 Countries by Total Production (2021-2023) ?
SELECT 
	country_name, 
	 ROUND(SUM(value),2) AS total_production
FROM 
	oil_cleaned
GROUP BY 
	country_name
ORDER BY 
	total_production DESC
LIMIT 5;

-- 3) Production Trends by Product Type
SELECT 
	product, 
    year, 
    ROUND(SUM(value),2) AS total_production
FROM 
	oil_cleaned
GROUP BY 
	product, 
    year
ORDER BY 
	product, 
    year;
    
-- 4) Production Value by Flow Analysis
-- Flow By Year
SELECT
    year,
    flow,
    ROUND(SUM(value), 2) AS total_production
FROM 
	oil_cleaned
WHERE
    flow IN ('net deliveries', 'industrial production')  -- Assuming these are the flows to analyze for export/import
GROUP BY
    year, flow
ORDER BY
    year;

-- Mapping the Flow into Category
SELECT 
    year,
    CASE 
        WHEN flow = 'net deliveries' THEN 'Export'
        WHEN flow = 'industrial production' THEN 'Domestic'
        WHEN flow = 'consumption pattern' THEN 'Domestic Consumption'
        WHEN flow = 'storage channelization' THEN 'Storage'
        ELSE 'Unknown'
    END AS flow_category,
    ROUND(SUM(value), 2) AS total_value
FROM 
	oil_cleaned
GROUP BY 
    year, 
    flow_category
ORDER BY 
    year;