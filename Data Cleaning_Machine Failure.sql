-- DATA CLEANING

-- Dataset from Kaggle : https://www.kaggle.com/datasets/umerrtx/machine-failure-prediction-using-sensor-data/data

-- Columns Description
-- footfall: The number of people or objects passing by the machine.
-- tempMode: The temperature mode or setting of the machine.
-- AQ: Air quality index near the machine.
-- USS: Ultrasonic sensor data, indicating proximity measurements.
-- CS: Current sensor readings, indicating the electrical current usage of the machine.
-- VOC: Volatile organic compounds level detected near the machine.
-- RP: Rotational position or RPM (revolutions per minute) of the machine parts.
-- IP: Input pressure to the machine.
-- Temperature: The operating temperature of the machine.
-- fail: Binary indicator of machine failure (1 for failure, 0 for no failure).

SELECT
	*
FROM
	machine_failure_data;

        
-- 1) Check for any missing values
SELECT 
    COUNT(*) AS TotalRecords,
    SUM(CASE WHEN footfall IS NULL THEN 1 ELSE 0 END) AS NullFootfall,
    SUM(CASE WHEN tempMode IS NULL THEN 1 ELSE 0 END) AS NullTempMode,
    SUM(CASE WHEN AQ IS NULL THEN 1 ELSE 0 END) AS NullAQ,
    SUM(CASE WHEN USS IS NULL THEN 1 ELSE 0 END) AS NullUSS,
    SUM(CASE WHEN CS IS NULL THEN 1 ELSE 0 END) AS NullCS,
    SUM(CASE WHEN VOC IS NULL THEN 1 ELSE 0 END) AS NullVOC,
    SUM(CASE WHEN RP IS NULL THEN 1 ELSE 0 END) AS NullRP,
    SUM(CASE WHEN IP IS NULL THEN 1 ELSE 0 END) AS NullIP,
    SUM(CASE WHEN Temperature IS NULL THEN 1 ELSE 0 END) AS NullTemperature,
    SUM(CASE WHEN fail IS NULL THEN 1 ELSE 0 END) AS NullFail
FROM 
	machine_failure_data;
    
-- 2) Check for any duplicates
SELECT 
	footfall, 
    tempMode, 
    AQ, 
    USS, 
    CS, 
    VOC, 
    RP, 
    IP, 
    Temperature, 
    fail, 
	COUNT(*) AS DuplicateCount
FROM 
	machine_failure_data
GROUP BY 
	footfall, 
    tempMode, 
    AQ, 
    USS, 
    CS, 
    VOC, 
    RP, 
    IP, 
    Temperature, 
    fail
HAVING 
	COUNT(*) > 1;
    
-- Create another table and remove duplicates
CREATE TABLE 
	cleaned_machine_data AS
SELECT 
	DISTINCT 
		footfall, 
        tempMode, 
        AQ, 
        USS, 
        CS, 
        VOC, 
        RP, 
        IP, 
        Temperature, 
        fail
FROM 
	machine_failure_data;
    
-- Check new table
SELECT 
	footfall, 
	tempMode, 
	AQ, 
	USS, 
	CS, 
	VOC, 
	RP, 
	IP, 
	Temperature, 
	fail, 
	COUNT(*) AS DuplicateCount
FROM 
	cleaned_machine_data
GROUP BY 
	footfall, 
    tempMode, 
    AQ, 
    USS, 
    CS, 
    VOC, 
    RP, 
    IP, 
    Temperature, 
    fail
HAVING 
	COUNT(*) > 1;

-- New cleaned table
SELECT
	*
FROM 
	cleaned_machine_data;
	

-- 3) Detect outliers using Z-score method (for numeric columns)
SELECT 
	*, 
    ROUND((footfall - (SELECT 
					AVG(footfall) 
				FROM cleaned_machine_data)) / 
                (SELECT 
					STD(footfall) 
                FROM cleaned_machine_data),3) AS Z_Score_Footfall
FROM 
	cleaned_machine_data
HAVING 
	ABS(Z_Score_Footfall) > 3;

-- Verify source of outliers    
SELECT 
	footfall, 
    COUNT(*) AS Count
FROM 
	cleaned_machine_data
WHERE 
	footfall = 7300
GROUP BY 
	footfall;

-- Note: Decide to retain the rows but to note that the footfall of 7300 is an outliers & require more attention in further analysis
