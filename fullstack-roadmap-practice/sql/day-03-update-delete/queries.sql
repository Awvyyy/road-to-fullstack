UPDATE job_applications
SET status = 'INTERVIEW'
WHERE id = 1
RETURNING *;

UPDATE job_applications
SET salary_expectation = 2700
WHERE id = 2
RETURNING *;

SELECT *
FROM job_applications
WHERE status = 'REJECTED';


DELETE FROM job_applications
WHERE id = 10
RETURNING *;

UPDATE job_applications
SET status = 'INTERVIEW'
WHERE company_name = 'SEB'
RETURNING *;

UPDATE job_applications
SET salary_expectation = 2000
WHERE status = 'SAVED'
RETURNING *;

UPDATE job_applications
SET status = 'REJECTED'
WHERE salary_expectation < 1800
RETURNING *;

SELECT *
FROM job_applications
WHERE status = 'REJECTED';

DELETE FROM job_applications
WHERE status = 'REJECTED'
RETURNING *;

SELECT *
FROM job_applications
ORDER BY id ASC;

UPDATE job_applications
SET salary_expectation = salary_expectation + 300
WHERE status = 'INTERVIEW'
RETURNING *;

UPDATE job_applications
SET salary_expectation = NULL
WHERE status = 'SAVED'
RETURNING *;

SELECT *
FROM job_applications
WHERE salary_expectation IS NULL;

UPDATE job_applications
SET salary_expectation = 2000
WHERE salary_expectation IS NULL
RETURNING *;

SELECT *
FROM job_applications
WHERE status = 'REJECTED'
  AND salary_expectation < 2000;

DELETE FROM job_applications
WHERE status = 'REJECTED'
 AND salary_expectation < 2000
RETURNING *;