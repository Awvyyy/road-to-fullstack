SELECT company_name, position
FROM job_applications;

SELECT *
FROM job_applications
WHERE status = 'APPLIED';

SELECT *
FROM job_applications
WHERE salary_expectation >= 1800;

SELECT *
FROM job_applications
ORDER BY salary_expectation DESC;

SELECT *
FROM job_applications
LIMIT 3;

SELECT *
FROM job_applications
WHERE status = 'INTERVIEW';

SELECT *
FROM job_applications
WHERE salary_expectation <= 2000;

SELECT company_name, position, status
FROM job_applications;

SELECT *
FROM job_applications
ORDER BY created_at;

SELECT *
FROM job_applications
LIMIT 5;


