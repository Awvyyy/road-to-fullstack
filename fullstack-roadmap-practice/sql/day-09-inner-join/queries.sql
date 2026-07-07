SELECT
    ja.id AS application_id,
    ja.position,
    ja.status,
    c.company_name
FROM job_applications ja
INNER JOIN companies c ON ja.company_id = c.id;

SELECT
    ja.id AS application_id,
    ja.position,
    ja.status,
    u.email AS user_email
FROM job_applications ja
INNER JOIN users u ON ja.user_id = u.id;

SELECT
    ja.id AS application_id,
    ja.position,
    ja.status,
    c.company_name,
    u.email AS user_email
FROM job_applications ja
INNER JOIN companies c ON ja.company_id = c.id
INNER JOIN users u ON ja.user_id = u.id;

SELECT
    ja.position,
    ja.status,
    c.company_name,
    u.email AS user_email
FROM job_applications ja
INNER JOIN companies c ON ja.company_id = c.id
INNER JOIN users u ON ja.user_id = u.id
WHERE u.email = 'helpned1@gmail.com';

SELECT
    ja.position,
    ja.status,
    c.company_name,
    u.email AS user_email
FROM job_applications ja
INNER JOIN companies c ON ja.company_id = c.id
INNER JOIN users u ON ja.user_id = u.id
WHERE c.company_name = 'SEB';

SELECT
    ja.position,
    ja.status,
    c.company_name,
    u.email AS user_email
FROM job_applications ja
INNER JOIN companies c ON ja.company_id = c.id
INNER JOIN users u ON u.id = ja.user_id
WHERE ja.status = 'APPLIED';

SELECT
    ja.position,
    ja.status,
    c.company_name,
    u.email AS user_email,
    ja.applied_at
FROM job_applications ja
INNER JOIN companies c ON ja.company_id = c.id
INNER JOIN users u ON ja.user_id = u.id
ORDER BY ja.applied_at DESC;

SELECT
    ja.id AS application_id,
    u.email AS candidate_email,
    c.company_name,
    ja.position,
    ja.status,
    ja.salary_expectation,
    ja.applied_at
FROM job_applications ja
INNER JOIN users u ON ja.user_id = u.id
INNER JOIN companies c ON ja.company_id = c.id
ORDER BY ja.applied_at DESC;