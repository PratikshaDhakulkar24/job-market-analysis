
 
CREATE DATABASE IF NOT EXISTS job_market;
USE job_market;
 

SELECT COUNT(*) AS total_jobs FROM jobs;
 
-- Preview the first rows of the table
SELECT * FROM jobs LIMIT 100;
 
 
-- ------------------------------------------------------------
-- PART 2: ANALYSIS
-- ------------------------------------------------------------
USE job_market;
 
-- Q1. How many Data Analyst jobs are there?  (1049)
SELECT COUNT(*) AS da_jobs
FROM jobs
WHERE Job_Role LIKE '%Data Analyst%';
 
 
-- Q2. Skill demand in Data Analyst jobs (% of jobs mentioning each skill)
SELECT 'SQL' AS skill, ROUND(AVG(`sql`) * 100, 1) AS pct FROM jobs WHERE Job_Role LIKE '%Data Analyst%'
UNION ALL SELECT 'Excel',    ROUND(AVG(excel)    * 100, 1) FROM jobs WHERE Job_Role LIKE '%Data Analyst%'
UNION ALL SELECT 'Python',   ROUND(AVG(python)   * 100, 1) FROM jobs WHERE Job_Role LIKE '%Data Analyst%'
UNION ALL SELECT 'Tableau',  ROUND(AVG(tableau)  * 100, 1) FROM jobs WHERE Job_Role LIKE '%Data Analyst%'
UNION ALL SELECT 'Power BI', ROUND(AVG(power_bi) * 100, 1) FROM jobs WHERE Job_Role LIKE '%Data Analyst%'
ORDER BY pct DESC;
 
 
-- Q3. Top 10 cities for Data Analyst jobs
SELECT city, COUNT(*) AS da_jobs
FROM jobs
WHERE Job_Role LIKE '%Data Analyst%'
GROUP BY city
ORDER BY da_jobs DESC
LIMIT 10;
 
 
-- Q4. Data Analyst jobs by experience band
SELECT exp_band, COUNT(*) AS da_jobs
FROM jobs
WHERE Job_Role LIKE '%Data Analyst%'
GROUP BY exp_band
ORDER BY da_jobs DESC;
 
 
-- Q5. How skill demand changes with experience (key insight)
SELECT exp_band,
       COUNT(*) AS jobs,
       ROUND(AVG(`sql`)    * 100, 1) AS sql_pct,
       ROUND(AVG(excel)    * 100, 1) AS excel_pct,
       ROUND(AVG(python)   * 100, 1) AS python_pct,
       ROUND(AVG(power_bi) * 100, 1) AS powerbi_pct
FROM jobs
WHERE Job_Role LIKE '%Data Analyst%'
GROUP BY exp_band
ORDER BY exp_band;
 
 
-- Q6. Which skills appear together in Data Analyst jobs
SELECT SUM(`sql` = 1 AND excel = 1)    AS sql_excel,
       SUM(`sql` = 1 AND power_bi = 1) AS sql_powerbi,
       SUM(`sql` = 1 AND python = 1)   AS sql_python,
       SUM(excel = 1 AND power_bi = 1) AS excel_powerbi
FROM jobs
WHERE Job_Role LIKE '%Data Analyst%';
 
 
-- Q7. Skill demand: Data Analyst vs Business Analyst vs Data Scientist
SELECT CASE
           WHEN Job_Role LIKE '%Data Analyst%'     THEN 'Data Analyst'
           WHEN Job_Role LIKE '%Business Analyst%' THEN 'Business Analyst'
           WHEN Job_Role LIKE '%Data Scientist%'   THEN 'Data Scientist'
       END AS role_group,
       COUNT(*) AS jobs,
       ROUND(AVG(`sql`)    * 100, 1) AS sql_pct,
       ROUND(AVG(excel)    * 100, 1) AS excel_pct,
       ROUND(AVG(python)   * 100, 1) AS python_pct,
       ROUND(AVG(power_bi) * 100, 1) AS powerbi_pct
FROM jobs
WHERE Job_Role LIKE '%Data Analyst%'
   OR Job_Role LIKE '%Business Analyst%'
   OR Job_Role LIKE '%Data Scientist%'
GROUP BY role_group
ORDER BY jobs DESC;
 
 
-- Q8. Fresher (0-2 yrs) Data Analyst jobs in Pune
SELECT Job_Role, Company, Job_Experience
FROM jobs
WHERE Job_Role LIKE '%Data Analyst%'
  AND city = 'Pune'
  AND exp_band = '0-2 yrs'
LIMIT 50;
 
