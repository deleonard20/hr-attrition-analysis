-- Employee Attrition Analysis
-- Author: Deleonard Simanjorang
-- Dataset: hr_attrition

-- 1. Data Understanding

-- Total rows
SELECT COUNT(*) AS total_rows
FROM hr_attrition;

-- Total columns
SELECT COUNT(*) AS total_columns
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'hr_attrition';

-- Data preview
SELECT *
FROM hr_attrition
LIMIT 10;

-- 2. Data Quality Check

-- Missing values (single column)
SELECT *
FROM hr_attrition
WHERE Attrition IS NULL;

-- Missing values (multiple columns)
SELECT
  SUM(CASE WHEN Age IS NULL THEN 1 ELSE 0 END) AS missing_age,
  SUM(CASE WHEN Attrition IS NULL THEN 1 ELSE 0 END) AS missing_attrition,
  SUM(CASE WHEN Department IS NULL THEN 1 ELSE 0 END) AS missing_department,
  SUM(CASE WHEN MonthlyIncome IS NULL THEN 1 ELSE 0 END) AS missing_monthly_income,
  SUM(CASE WHEN OverTime IS NULL THEN 1 ELSE 0 END) AS missing_overtime,
  SUM(CASE WHEN YearsAtCompany IS NULL THEN 1 ELSE 0 END) AS missing_years_at_company
FROM hr_attrition;

-- 3. Attrition Analysis

-- Overall attrition rate
SELECT
  Attrition,
  COUNT(*) AS total_employee,
  ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS attrition_rate_pct
FROM hr_attrition
GROUP BY Attrition;

-- Attrition by overtime
SELECT 
  OverTime, 
  COUNT(*) AS total_employee, 
  SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS resigned, 
  ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate_pct 
FROM hr_attrition 
GROUP BY OverTime;

-- Attrition by tenure
SELECT 
  YearsAtCompany, 
  COUNT(*) AS total_employee, 
  SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS resigned, 
  ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate_pct 
FROM hr_attrition 
GROUP BY YearsAtCompany;