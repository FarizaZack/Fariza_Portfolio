-- B) Data Exploration

-- Datasets : https://www.kaggle.com/datasets/rhuebner/human-resources-data-set/data

SELECT
	*
FROM
	hrdata;

-- 1) Summary Statistics
SELECT
    COUNT(*) AS total_records,
    COUNT(DISTINCT EmpID) AS unique_employees,
    ROUND(AVG(Salary),0) AS avg_salary,
    MAX(Salary) AS max_salary,
    MIN(Salary) AS min_salary,
    ROUND(AVG(Absences),0) AS avg_absences,
    ROUND(AVG(EngagementSurvey),2) AS avg_engagement
FROM 
	hrdata;

-- 2) Employee Distribution by Gender & Marital Status
SELECT 
	GenderID, 
	COUNT(*) AS count_gender
FROM 
	hrdata
GROUP BY 
	GenderID;

SELECT 
	MaritalStatusID, 
	COUNT(*) AS count_marital_status
FROM 
	hrdata
GROUP BY 
	MaritalStatusID;

-- 3) Performance by Department or Position
SELECT 
	Department, 
    ROUND(AVG(PerfScoreID),0) AS avg_perf_score
FROM 
	hrdata
GROUP BY 
	Department;

SELECT 
	Position, 
	ROUND(AVG(PerfScoreID),0) AS avg_perf_score
FROM 
	hrdata
GROUP BY 
	Position;

-- 4) Checking on reason of termination
SELECT 
	TermReason, 
    COUNT(*) AS term_count
FROM 
	hrdata
WHERE 
	Termd = 1
GROUP BY 
	TermReason
ORDER BY
	term_count DESC;
    
-- 5) Any correlation between Absences & Performance Score ?
SELECT 
	Absences, 
    PerfScoreID
FROM 
	hrdata;

-- Statistics of Absences
SELECT 
    MIN(Absences) AS MinAbsences,
    MAX(Absences) AS MaxAbsences,
    ROUND(AVG(Absences),0) AS AvgAbsences,
    ROUND(STDDEV(Absences),0) AS StdDevAbsences
FROM 
    hrdata;
    
-- Statistics of Performance
SELECT 
    MIN(PerfScoreID) AS MinPerformanceScore,
    MAX(PerfScoreID) AS MaxPerformanceScore,
    ROUND(AVG(PerfScoreID),0) AS AvgPerformanceScore,
    ROUND(STDDEV(PerfScoreID),0) AS StdDevPerformanceScore
FROM 
    hrdata;

-- 6) How Engagement Survey Score are distributed?
SELECT 
	ROUND(AVG(EngagementSurvey),2) AS avg_engagement_score
FROM 
	hrdata;

SELECT 
	EngagementSurvey, 
	COUNT(*) AS count
FROM 
	hrdata
GROUP BY 
	EngagementSurvey
ORDER BY
	EngagementSurvey;