SELECT
    ja.id AS application_id,
    ja.position,
    ja.status,
    ja.salary_expectation,
    ja.applied_at
FROM job_applications ja
ORDER BY applied_at DESC;

SELECT
    ja.id AS application_id,
    ja.position,
    ja.status,
    ja.salary_expectation
FROM job_applications ja
WHERE status = 'APPLIED'
ORDER BY  salary_expectation DESC NULLS LAST;

SELECT
    ja.id AS application_id,
    ja.position,
    ja.status,
    c.company_name
FROM job_applications ja
INNER JOIN companies c ON c.id = ja.company_id;

SELECT
    ja.id AS application_id,
    u.email AS user_email,
    c.company_name,
    ja.position,
    ja.status
FROM job_applications ja
INNER JOIN users u ON u.id = ja.user_id
INNER JOIN companies c ON c.id = ja.company_id;

SELECT
    c.id AS company_id,
    c.company_name,
    ja.id AS application_id,
    ja.position,
    ja.status
FROM companies c
LEFT JOIN job_applications ja ON ja.company_id = c.id;

SELECT
    c.id AS company_id,
    c.company_name
FROM companies c
LEFT JOIN job_applications ja ON ja.company_id = c.id
WHERE ja.id IS NULL;

SELECT
    c.id AS company_id,
    c.company_name,
    COUNT(ja.id) AS application_count
FROM companies c
LEFT JOIN job_applications ja ON ja.company_id = c.id
GROUP BY c.id, c.company_name
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
LEFT JOIN job_applications ja ON ja.company_id = c.id
GROUP BY  c.id, c.company_name;

SELECT
    c.id AS company_id,
    c.company_name,
    COUNT(ja.id) AS application_count
FROM companies c
LEFT JOIN job_applications ja ON ja.company_id = c.id
GROUP BY c.id, c.company_name
HAVING COUNT(ja.id) > 1;

SELECT
    c.id AS company_id,
    c.company_name,
    AVG(ja.salary_expectation) AS average_salary_expectation
FROM companies c
LEFT JOIN job_applications ja ON ja.company_id = c.id
GROUP BY c.id, c.company_name
HAVING AVG(ja.salary_expectation) > 3000;

SELECT
    ja.id AS application_id,
    ja.position,
    ja.salary_expectation
FROM job_applications ja
WHERE ja.salary_expectation > (
    SELECT
        AVG(ja_inner.salary_expectation)
    FROM job_applications ja_inner
    );

SELECT
    c.id AS company_id,
    c.company_name
FROM companies c
WHERE EXISTS(
    SELECT 1
    FROM job_applications ja
    WHERE ja.company_id = c.id
);

SELECT
    c.id AS company_id,
    c.company_name
FROM companies c
WHERE NOT EXISTS(
    SELECT 1
    FROM job_applications ja
    WHERE ja.company_id = c.id
);

SELECT
    ja_outer.id AS application_id,
    ja_outer.company_id,
    ja_outer.position,
    ja_outer.salary_expectation
FROM job_applications ja_outer
WHERE ja_outer.salary_expectation > (
    SELECT
        AVG(ja_inner.salary_expectation)
    FROM job_applications ja_inner
    WHERE ja_inner.company_id = ja_outer.company_id
    );

