SELECT
    c.id AS company_id,
    c.company_name,
    ja.id AS application_id,
    ja.position,
    ja.status
FROM companies c
LEFT JOIN job_applications ja ON  c.id = ja.company_id;

SELECT
    u.id,
    u.email,
    ja.id,
    ja.position,
    ja.status
FROM users u
LEFT JOIN job_applications ja ON ja.user_id = u.id;

SELECT
    c.company_name,
    ja.position
FROM companies c
LEFT JOIN job_applications ja ON ja.company_id = c.id;

SELECT
    c.company_name,
    ja.position
FROM companies c
         INNER JOIN job_applications ja ON ja.company_id = c.id;

SELECT
    c.id,
    c.company_name
FROM companies c
LEFT JOIN job_applications ja ON ja.company_id = c.id
WHERE ja.id IS NULL;

SELECT
    u.id AS user_id,
    u.email AS user_email
FROM users u
LEFT JOIN job_applications ja ON u.id = ja.user_id
WHERE ja.id IS NULL;

SELECT
    c.company_name,
    ja.position,
    ja.status
FROM companies c
LEFT JOIN job_applications ja ON ja.company_id = c.id
AND ja.status = 'APPLIED';

SELECT
    c.company_name,
    ja.position,
    ja.status,
    u.email AS user_email
FROM companies c
LEFT JOIN job_applications ja ON ja.company_id = c.id
LEFT JOIN users u ON u.id = ja.user_id;

SELECT
    c.id AS company_id,
    c.company_name,
    ja.id AS application_id,
    ja.position,
    ja.status,
    u.email AS candidate_email,
    ja.salary_expectation,
    ja.applied_at
FROM companies c
LEFT JOIN job_applications ja ON ja.company_id = c.id
LEFT JOIN users u ON u.id = ja.user_id
ORDER BY c.company_name ASC, ja.applied_at DESC;

SELECT
    c.company_name,
    ja.position,
    COALESCE(ja.status, 'NO APPLICATION') AS application_status
FROM companies c
LEFT JOIN job_applications ja ON ja.company_id = c.id;

SELECT
    c.id AS company_id,
    c.company_name
FROM companies c
LEFT JOIN job_applications ja ON ja.company_id = c.id
AND ja.status = 'APPLIED'
WHERE ja.id IS NULL;