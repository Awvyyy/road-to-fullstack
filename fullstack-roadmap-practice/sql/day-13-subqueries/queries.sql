SELECT
    ja.id AS application_id,
    ja.position,
    ja.status,
    ja.salary_expectation
FROM job_applications ja
WHERE ja.salary_expectation > (
    SELECT
        AVG(ja_inner.salary_expectation)
    FROM job_applications ja_inner
    );

SELECT
    ja.id AS application_id,
    ja.position,
    ja.salary_expectation
FROM job_applications ja
WHERE ja.salary_expectation = (
    SELECT
        MAX(ja.salary_expectation)
    FROM job_applications ja
    );

SELECT
    c.id AS company_id,
    c.company_name
FROM companies c
WHERE c.id IN (
    SELECT
        ja.company_id
    FROM job_applications ja
    );

SELECT
    c.id AS company_id,
    c.company_name
FROM companies c
WHERE c.id NOT IN (
    SELECT
        ja.company_id
    FROM job_applications ja
);

SELECT
    c.id AS company_id,
    c.company_name
FROM companies c
WHERE EXISTS (
    SELECT 1
    FROM job_applications ja
    WHERE ja.company_id = c.id
);

SELECT
    c.id AS company_id,
    c.company_name
FROM companies c
WHERE NOT EXISTS (
    SELECT 1
    FROM job_applications ja
    WHERE ja.company_id = c.id
);

SELECT
    u.id AS user_id,
    u.email AS user_email
FROM users u
WHERE EXISTS (
    SELECT 1
    FROM job_applications ja
    WHERE ja.user_id = u.id AND
        ja.status = 'APPLIED'
);

SELECT
    stats.company_id AS company_id,
    stats.application_count AS application_count
FROM (
    SELECT
        ja.company_id,
        COUNT(ja.id) AS application_count
    FROM job_applications ja
    GROUP BY company_id
     ) stats
WHERE stats.application_count > 1;

SELECT
    ja.id AS application_id,
    ja.company_id,
    ja.position,
    ja.status
FROM job_applications ja
WHERE ja.company_id IN (
    SELECT
        ja.company_id
    FROM job_applications ja
    GROUP BY ja.company_id
    HAVING COUNT(*) > 1
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
    WHERE ja_outer.company_id = ja_inner.company_id
    );



