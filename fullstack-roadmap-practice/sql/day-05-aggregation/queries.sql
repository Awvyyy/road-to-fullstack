-- 1. Count all job applications
SELECT COUNT(*)
FROM job_applications;

-- 2. Count applications by status
SELECT status, COUNT(*)
FROM job_applications
GROUP BY status;

-- 3. Find minimum salary expectation
SELECT MIN(salary_expectation)
FROM job_applications;

-- 4. Find maximum salary expectation
SELECT MAX(salary_expectation)
FROM job_applications;

-- 5. Find average salary expectation
SELECT AVG(salary_expectation)
FROM job_applications;

-- 6. Find average salary by status
SELECT status, AVG(salary_expectation)
FROM job_applications
GROUP BY status;

-- 7. Count applications by company
SELECT company_name, COUNT(*)
FROM job_applications
GROUP BY company_name;

-- 8. Count applications by status, sorted by count descending
SELECT status, COUNT(*)
FROM job_applications
GROUP BY status
ORDER BY COUNT(*) DESC;

-- 9. Find max salary for each status
SELECT status, MAX(salary_expectation)
FROM job_applications
GROUP BY status;

-- 10. Find min salary for each status
SELECT status, MIN(salary_expectation)
FROM job_applications
GROUP BY status;

-- 11. Count rows, where salary_expectation IS NOT NULL
SELECT COUNT(*)
FROM job_applications
WHERE salary_expectation IS NOT NULL;

-- 12. Count unique statuses
SELECT COUNT(DISTINCT status)
FROM job_applications;
