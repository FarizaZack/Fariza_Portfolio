-- Loan Risk Analysis

-- Data from : https://www.kaggle.com/datasets/vedaantsingh/loan-application-risk-prediction-data?select=loan_applications.csv

-- Explore Dataset
SELECT
	*
FROM
	credit_features;
    
SELECT
	*
FROM
	loan_applications;

-- Load and merge datasets
SELECT 
    la.UID,
    la.ApplicationDate,
    la.Amount,
    la.Term,
    la.EmploymentType,
    la.LoanPurpose,
    cf.ALL_AgeOfOldestAccount,
    cf.ALL_AgeOfYoungestAccount,
    cf.ALL_Count,
    cf.ALL_CountActive,
    cf.ALL_CountClosedLast12Months,
    cf.ALL_CountDefaultAccounts,
    cf.ALL_MeanAccountAge,
    cf.ALL_SumCurrentOutstandingBal,
    cf.ALL_SumCurrentOutstandingBalExcMtg,
    cf.ALL_TimeSinceMostRecentDefault,
    cf.ALL_WorstPaymentStatusActiveAccounts,
    la.Success
FROM 
    loan_applications la
LEFT JOIN 
    credit_features cf
ON 
    la.UID = cf.UID;
    
-- Check for missing values
SELECT 
    COUNT(*) AS TotalRows,
    SUM(CASE WHEN la.Amount IS NULL THEN 1 ELSE 0 END) AS MissingAmount,
    SUM(CASE WHEN cf.ALL_AgeOfOldestAccount IS NULL THEN 1 ELSE 0 END) AS MissingOldestAccountAge,
    SUM(CASE WHEN cf.ALL_Count IS NULL THEN 1 ELSE 0 END) AS MissingAccountCount
FROM 
    loan_applications la
LEFT JOIN 
    credit_features cf
ON 
    la.UID = cf.UID;    
    
-- Feature Engineering: Create new features
SELECT 
    la.UID,
    la.Amount,
    la.Term,
    la.EmploymentType,
    la.LoanPurpose,
    cf.ALL_AgeOfOldestAccount,
    cf.ALL_AgeOfYoungestAccount,
    (cf.ALL_AgeOfOldestAccount - cf.ALL_AgeOfYoungestAccount) AS AccountAgeDifference, -- To capture range of account ages to reflect credit experience
    cf.ALL_Count,
    cf.ALL_CountDefaultAccounts,
    (CAST(cf.ALL_CountDefaultAccounts AS FLOAT) / NULLIF(cf.ALL_Count, 0)) AS DefaultRiskRatio, -- To calculate no. of default accounts among all credit accounts
    (cf.ALL_SumCurrentOutstandingBal / NULLIF(cf.ALL_CountActive, 0)) AS AvgOutstandingBalancePerAccount, -- To get average outstanding balance per active acc to assess financial exposures
    la.Success -- whether the loan application was successful (1) or rejected (0).
FROM 
    loan_applications la
LEFT JOIN 
    credit_features cf -- So both table records are retained
ON 
    la.UID = cf.UID;

-- Analyze loan success rate by EmploymentType
SELECT 
    la.EmploymentType,
    COUNT(*) AS TotalApplications,
    SUM(CASE WHEN la.Success = 1 THEN 1 ELSE 0 END) AS SuccessfulApplications,
    ROUND(SUM(CASE WHEN la.Success = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS SuccessRate -- To get success rate in % but in 2 decimal places
FROM 
    loan_applications la
GROUP BY 
    la.EmploymentType
ORDER BY 
    SuccessRate DESC; -- To prioritize employment type by sucess rates

-- Analyze loan success by Credit Attributes
SELECT 
    cf.ALL_Count, -- Total no. credit account for applicants
    cf.ALL_CountDefaultAccounts, -- total no. default acc for applicant
    ROUND(AVG(CASE WHEN la.Success = 1 THEN cf.ALL_MeanAccountAge ELSE NULL END), 2) AS AvgAccountAge_Successful, -- Average age of accounts for succesful loan applicants
    ROUND(AVG(CASE WHEN la.Success = 0 THEN cf.ALL_MeanAccountAge ELSE NULL END), 2) AS AvgAccountAge_Unsuccessful -- Average age of accounts for unsuccesful loan applicants
FROM 
    loan_applications la
LEFT JOIN 
    credit_features cf -- To get all record even if there's no matching record
ON 
    la.UID = cf.UID
GROUP BY -- To group applicants with similar count of total & default accounts
    cf.ALL_Count,
    cf.ALL_CountDefaultAccounts
ORDER BY 
    cf.ALL_Count ASC; -- Sort by no. credit acc in ascending order
    
-- Trend identify:
-- 1) Whether having more accounts impacts loan success.
-- 2) How the number of default accounts affects loan approval.
-- 3) Differences in account age between successful and unsuccessful applicants.

-- Give insight on loan risk modelling & applicant profiling. Inform lending policies on key credit factors impact loan decisions

