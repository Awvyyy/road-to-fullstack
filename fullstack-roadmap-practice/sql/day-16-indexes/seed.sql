INSERT INTO job_applications (
    user_id,
    company_id,
    position,
    status,
    salary_expectation
)
SELECT
    CASE
        WHEN gs % 3 = 1 THEN 2
        WHEN gs % 3 = 2 THEN 4
        ELSE 5
        END AS user_id,
    ((gs - 1) % 3) + 1 AS company_id,
    'Java Developer ' || gs AS position,
    CASE
        WHEN gs % 5 = 0 THEN 'SAVED'
        WHEN gs % 5 = 1 THEN 'APPLIED'
        WHEN gs % 5 = 2 THEN 'INTERVIEW'
        WHEN gs % 5 = 3 THEN 'OFFER'
        ELSE 'REJECTED'
        END AS status,
    CASE
        WHEN gs % 10 = 0 THEN NULL
        ELSE 2000 + (gs % 4000)
        END AS salary_expectation
FROM generate_series(1, 10000) AS gs;

SELECT COUNT(*)
FROM job_applications;

DROP INDEX idx_job_applications_user_id;

EXPLAIN
SELECT *
FROM job_applications
WHERE user_id = 2;

CREATE INDEX idx_job_applications_user_id
    ON job_applications (user_id);

ANALYZE job_applications;

SELECT
    user_id,
    COUNT(*) AS applications_count
FROM job_applications
GROUP BY user_id
ORDER BY user_id