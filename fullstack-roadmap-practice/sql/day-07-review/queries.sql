-- 1. Find all applied applications ordered by salary descending
SELECT *
FROM job_applications
WHERE status = 'APPLIED'
ORDER BY salary_expectation DESC;

-- 2. Find top 3 applications with the highest salary expectation
SELECT *
FROM job_applications
ORDER BY salary_expectation DESC
LIMIT 3;

-- 3. Find all applications where company name starts with S
SELECT *
FROM job_applications
WHERE company_name LIKE 'S%';

-- 4. Find all applications where position contains Java
SELECT *
FROM job_applications
WHERE position LIKE '%Java%';

-- 5. Count applications by status
SELECT status, COUNT(*) AS applications_count
FROM job_applications
GROUP BY status;

-- 6. Find average salary expectation by status
SELECT status, AVG(salary_expectation) AS average_salary_expectation
FROM job_applications
GROUP BY status;

-- 7. Find statuses where application count is greater than 1
SELECT status, COUNT(*) AS applications_count
FROM job_applications
GROUP BY status
HAVING COUNT(*) > 1;

-- 8. Find statuses where average salary expectation is greater than 2000
SELECT status, AVG(salary_expectation) AS average_salary_expectation
FROM job_applications
GROUP BY status
HAVING AVG(salary_expectation) > 2000;

-- 9. Update one application by id and return updated row
UPDATE job_applications
SET status = 'SAVED'
WHERE id = 1
RETURNING *;

-- 10. Delete one application by id and return deleted row
DELETE FROM job_applications
WHERE id = 2
RETURNING *;