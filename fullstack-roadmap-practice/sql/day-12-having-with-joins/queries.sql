SELECT
    c.id AS company_id,
    c.company_name,
    COUNT(ja.id) AS application_count
FROM companies c
LEFT JOIN job_applications ja ON c.id = ja.company_id
GROUP BY c.id, c.company_name
HAVING COUNT(ja.id) > 1
ORDER BY application_count DESC;

SELECT
    c.id AS company_id,
    c.company_name,
    COUNT(ja.id) AS application_count
FROM companies c
LEFT JOIN job_applications ja ON c.id = ja.company_id
GROUP BY c.id, c.company_name
HAVING COUNT(ja.id) = 0;

SELECT
    u.id AS user_id,
    u.email AS user_email,
    COUNT(ja.id) AS applications_count
FROM users u
LEFT JOIN job_applications ja ON ja.user_id = u.id
GROUP BY  u.id, u.email
HAVING COUNT(ja.id) > 1;

SELECT
    u.id AS user_id,
    u.email AS user_email,
    COUNT(ja.id) AS applications_count
FROM users u
         LEFT JOIN job_applications ja ON ja.user_id = u.id
GROUP BY  u.id, u.email
HAVING COUNT(ja.id) = 0;

SELECT
    c.id AS company_id,
    c.company_name,
    COUNT(ja.id) FILTER ( WHERE ja.status = 'APPLIED' ) AS applied_count
FROM companies c
LEFT JOIN job_applications ja ON ja.company_id = c.id
GROUP BY c.id, c.company_name
HAVING COUNT(ja.id) FILTER ( WHERE ja.status = 'APPLIED' ) > 0;

SELECT
    c.id AS company_id,
    c.company_name,
    COUNT(ja.id) FILTER ( WHERE ja.status = 'REJECTED' ) AS rejected_count
FROM companies c
LEFT JOIN job_applications ja ON ja.company_id = c.id
GROUP BY c.id, c.company_name
HAVING COUNT(ja.id) FILTER ( WHERE ja.status = 'REJECTED' ) = 0;

SELECT
    c.id AS company_id,
    c.company_name,
    AVG(ja.salary_expectation) AS average_salary
FROM companies c
         LEFT JOIN job_applications ja ON ja.company_id = c.id
GROUP BY c.id, c.company_name
HAVING AVG(ja.salary_expectation) > 3000;

SELECT
    u.id AS user_id,
    u.email AS user_email,
    AVG(ja.salary_expectation) AS average_salary_expectation
FROM users u
LEFT JOIN job_applications ja ON ja.user_id = u.id
GROUP BY u.id, u.email
HAVING AVG(ja.salary_expectation) > 3000;

SELECT
    c.id AS company_id,
    c.company_name,
    COUNT(ja.id) FILTER ( WHERE ja.status = 'APPLIED' ) AS applied_count,
    COUNT(ja.id) FILTER ( WHERE ja.status = 'REJECTED' ) AS rejected_count
FROM companies c
LEFT JOIN job_applications ja ON ja.company_id = c.id
GROUP BY  c.id, c.company_name
HAVING
    COUNT(ja.id) FILTER ( WHERE ja.status = 'APPLIED' )
        >
    COUNT(ja.id) FILTER ( WHERE ja.status = 'REJECTED' );