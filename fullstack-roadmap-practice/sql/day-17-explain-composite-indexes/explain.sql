ANALYZE job_applications;

EXPLAIN (ANALYZE, BUFFERS)
SELECT
    id,
    user_id,
    company_id,
    position,
    status,
    salary_expectation
FROM job_applications
WHERE user_id = 2
  AND status = 'INTERVIEW';