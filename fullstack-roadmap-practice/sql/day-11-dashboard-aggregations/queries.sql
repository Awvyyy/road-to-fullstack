SELECT
    c.id AS company_id,
    c.company_name,
    COUNT(ja.id) AS application_count
FROM companies c
LEFT JOIN job_applications ja ON c.id = ja.company_id
GROUP BY c.id, c.company_name
ORDER BY application_count DESC;

SELECT
    u.id AS user_id,
    u.email as user_email,
    COUNT(ja.id) AS application_count
FROM users u
LEFT JOIN job_applications ja ON u.id = ja.user_id
GROUP BY u.id, u.email
ORDER BY application_count DESC;

SELECT
    ja.status,
    COUNT(*) AS application_count
FROM job_applications ja
GROUP BY ja.status
ORDER BY application_count DESC;

SELECT
    c.id AS company_id,
    c.company_name,
    COUNT(ja.id) AS total_applications,
    COUNT(ja.id) FILTER ( WHERE ja.status = 'APPLIED' ) AS applied_count,
    COUNT(ja.id) FILTER ( WHERE ja.status = 'SAVED' ) AS saved_count,
    COUNT(ja.id) FILTER ( WHERE ja.status = 'INTERVIEW' ) AS interview_count,
    COUNT(ja.id) FILTER ( WHERE ja.status = 'REJECTED' ) AS rejected_count
FROM companies c
LEFT JOIN job_applications ja ON c.id = ja.company_id
GROUP BY c.id, c.company_name;

SELECT
    u.id AS user_id,
    u.email AS user_email,
    COUNT(ja.id) AS total_applications,
    COUNT(ja.id) FILTER ( WHERE ja.status = 'APPLIED' ) AS applied_count,
    COUNT(ja.id) FILTER ( WHERE ja.status = 'SAVED' ) AS saved_count,
    COUNT(ja.id) FILTER ( WHERE ja.status = 'INTERVIEW' ) AS interview_count,
    COUNT(ja.id) FILTER ( WHERE ja.status = 'REJECTED' ) AS rejected_count
FROM users u
LEFT JOIN job_applications ja ON u.id  = ja.user_id
GROUP BY u.id, u.email
ORDER BY u.id ASC;

SELECT
    c.id AS company_id,
    c.company_name,
    AVG(ja.salary_expectation) AS average_salary_expectation
FROM companies c
LEFT JOIN job_applications ja ON c.id = ja.company_id
GROUP BY c.id, c.company_name
ORDER BY average_salary_expectation DESC NULLS LAST;

SELECT
    c.id AS company_id,
    c.company_name,
    MIN(ja.salary_expectation) AS min_salary_expectation,
    MAX(ja.salary_expectation) AS max_salary_expectation
FROM companies c
LEFT JOIN job_applications ja ON c.id = ja.company_id
GROUP BY c.id, c.company_name
ORDER BY max_salary_expectation DESC NULLS LAST;

SELECT
    c.id AS company_id,
    c.company_name,
    COUNT(ja.id) AS applications_count
FROM companies c
LEFT JOIN job_applications ja ON c.id = ja.company_id
GROUP BY c.id, c.company_name
HAVING COUNT(ja.id) = 0;

