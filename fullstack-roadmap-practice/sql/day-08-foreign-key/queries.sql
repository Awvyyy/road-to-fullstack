SELECT * FROM job_applications;

SELECT * FROM companies;

SELECT *
FROM job_applications
WHERE user_id = 1;

SELECT *
FROM job_applications
WHERE status = 'APPLIED';

SELECT *
FROM job_applications
ORDER BY applied_at DESC;