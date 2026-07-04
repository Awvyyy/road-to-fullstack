-- 1. Find statuses that have more than 1 application
SELECT status, COUNT(*) AS applications_count
FROM job_applications
GROUP BY status
HAVING COUNT(*) > 1;

-- 2. Find companies that have more than 1 application
SELECT company_name, COUNT(*) AS applications_count
FROM job_applications
GROUP BY company_name
HAVING COUNT(*) > 1;

-- 3. Find statuses where average salary expectation is greater than 2000
SELECT status, AVG(salary_expectation) AS average_salary_expectation
FROM job_applications
GROUP BY status
HAVING AVG(salary_expectation) > 2000;

-- 4. Find statuses where max salary expectation is at least 2300
SELECT status, MAX(salary_expectation) AS max_salary_expectation
FROM job_applications
GROUP BY status
HAVING MAX(salary_expectation) >= 2300;

-- 5. Find companies where min salary expectation is less than 2000
SELECT company_name, MIN(salary_expectation) AS min_salary_expectation
FROM job_applications
GROUP BY company_name
HAVING MIN(salary_expectation) < 2000;

-- 6. Find statuses, where application count <= 2
SELECT status, COUNT(*) AS applications_count
FROM job_applications
GROUP BY status
HAVING COUNT(*) <= 2;

-- 7. Find statuses, where average salary_expectation > 1500 and < 2500
SELECT status, AVG(salary_expectation) AS avg_salary_expectation
FROM job_applications
GROUP BY status
HAVING AVG(salary_expectation) BETWEEN 1500 AND 2500;

-- 8. Find companies, where max salary_expectation > 2000
SELECT company_name, MAX(salary_expectation) AS max_salary_expectation
FROM job_applications
GROUP BY company_name
HAVING MAX(salary_expectation) > 2000;

-- 9. Find companies, where min salary < 2100
SELECT company_name, MIN(salary_expectation) AS min_salary_expectation
FROM job_applications
GROUP BY company_name
HAVING MIN(salary_expectation) < 2100;