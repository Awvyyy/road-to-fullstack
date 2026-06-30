SELECT *
FROM job_applications
WHERE status = 'APPLIED';

SELECT *
FROM job_applications
WHERE salary_expectation > 2000;

SELECT *
FROM job_applications
WHERE salary_expectation <= 1800;

SELECT *
FROM job_applications
WHERE status != 'REJECTED';

SELECT *
FROM job_applications
WHERE status = 'APPLIED'
  AND salary_expectation >= 2000;

SELECT *
FROM job_applications
WHERE status = 'INTERVIEW'
   OR status = 'SAVED';

SELECT *
FROM job_applications
WHERE status IN ('INTERVIEW', 'SAVED');

SELECT *
FROM job_applications
WHERE position LIKE '%Java%';

SELECT *
FROM job_applications
WHERE position LIKE 'S%';

SELECT *
FROM job_applications
WHERE salary_expectation IS NOT NULL;

SELECT *
FROM job_applications
WHERE salary_expectation >= 1800
  AND salary_expectation <= 3000;

SELECT *
FROM job_applications
WHERE position LIKE ('%Developer%')
 AND status != 'REJECTED';