-- DATA EXPLORATORY ANALYSIS

-- New cleaned table
SELECT
	*
FROM 
	cleaned_machine_data;
	
-- 1) Summary Statistics
SELECT 
    COUNT(*) AS TotalRecords,
    ROUND(AVG(footfall),0) AS AvgFootfall, 
    MIN(footfall) AS MinFootfall, 
    MAX(footfall) AS MaxFootfall,
    ROUND(AVG(AQ),0) AS AvgAQ, 
    MIN(AQ) AS MinAQ, 
    MAX(AQ) AS MaxAQ,
    ROUND(AVG(Temperature),0) AS AvgTemperature, 
    MIN(Temperature) AS MinTemperature, 
    MAX(Temperature) AS MaxTemperature
FROM 
	cleaned_machine_data;
    
    -- 2) Analyse failure distribution
SELECT 
	fail, 
	COUNT(*) AS Count, 
	ROUND((COUNT(*) / (SELECT COUNT(*) FROM cleaned_machine_data)) * 100, 2) AS Percentage
FROM 
	cleaned_machine_data
GROUP BY 
	fail;
    
-- Note: indicator of machine failure (1 for failure, 0 for no failure).
    
-- 3) Correction Analysis
SELECT 
    ROUND((COUNT(*) * SUM(footfall * Temperature) - SUM(footfall) * SUM(Temperature)) /
    (SQRT(COUNT(*) * SUM(POW(footfall, 2)) - POW(SUM(footfall), 2)) * 
     SQRT(COUNT(*) * SUM(POW(Temperature, 2)) - POW(SUM(Temperature), 2))),2) AS CorrFootfallTemperature,
     
    ROUND((COUNT(*) * SUM(AQ * fail) - SUM(AQ) * SUM(fail)) /
    (SQRT(COUNT(*) * SUM(POW(AQ, 2)) - POW(SUM(AQ), 2)) * 
     SQRT(COUNT(*) * SUM(POW(fail, 2)) - POW(SUM(fail), 2))),2) AS CorrAQFail,
     
    ROUND((COUNT(*) * SUM(RP * fail) - SUM(RP) * SUM(fail)) /
    (SQRT(COUNT(*) * SUM(POW(RP, 2)) - POW(SUM(RP), 2)) * 
     SQRT(COUNT(*) * SUM(POW(fail, 2)) - POW(SUM(fail), 2))),2) AS CorrRPFail
FROM 
	cleaned_machine_data;
    
-- Note: Correlation btwn Footfall & Temperature is No meaningful relationship (Zeroth-order correlation, close to zero). might consider removing them from predictive models if they don't provide useful information.
-- Note: Correlation btwn AQ & Machine Failure is Moderate positive relationship, suggesting poor air quality might contribute to machine failure. further analysis could help understand the underlying causes. It might be worth investigating other factors that could affect the machine failure rate.
-- Note : Correlation between RP (Rotational Position) and Fail (Machine Failure) is Very weak positive relationship, suggesting no significant connection between rotational position and failure in the machine.

-- 4) Analyze sensor trends based on failure
SELECT 
    fail,
    ROUND(AVG(footfall),0) AS AvgFootfall,
    ROUND(AVG(AQ),0) AS AvgAQ,
    ROUND(AVG(USS),0) AS AvgUSS,
    ROUND(AVG(CS),0) AS AvgCS,
    ROUND(AVG(VOC),0) AS AvgVOC,
    ROUND(AVG(RP),0) AS AvgRP,
    ROUND(AVG(IP),0) AS AvgIP,
    ROUND(AVG(Temperature),0) AS AvgTemperature
FROM 
	cleaned_machine_data
GROUP BY 
	fail;
    
-- 5) To find conditions that lead to failures
SELECT 
	*
FROM 
	cleaned_machine_data
WHERE 
	fail = 1
ORDER BY 
	Temperature DESC, 
    RP DESC
LIMIT 10;

-- 6) Frequency of temperature modes
SELECT 
	tempMode, 
    COUNT(*) AS Count
FROM 
	cleaned_machine_data
GROUP BY 
	tempMode
ORDER BY 
	Count DESC;