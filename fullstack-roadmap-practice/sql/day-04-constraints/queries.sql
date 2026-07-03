SELECT *
FROM job_applications
ORDER BY id ASC;

SELECT *
FROM job_applications
WHERE company_name = 'HELMES';

SELECT company_name, position, vacancy_url
FROM job_applications
WHERE vacancy_url IS NOT NULL;

SELECT *
FROM job_applications
WHERE salary_expectation IS NULL;

SELECT DISTINCT status
FROM job_applications
ORDER BY status ASC;