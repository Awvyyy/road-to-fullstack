SELECT
    indexname,
    indexdef
FROM pg_indexes
WHERE schemaname = 'public'
ORDER BY tablename, indexname;


-- This query gets all job applications for one user.
-- A useful index column is job_applications.user_id.
SELECT
    ja.user_id,
    c.id AS company_id,
    c.company_name,
    ja.position,
    ja.status,
    ja.applied_at
FROM job_applications ja
JOIN companies c ON c.id = ja.company_id
WHERE ja.user_id = 2;


-- This query gets all job applications for one company.
-- A useful index column is job_applications.company_id.
SELECT
    c.id AS company_id,
    c.company_name,
    ja.position,
    ja.salary_expectation
FROM companies c
JOIN job_applications ja ON ja.company_id = c.id
WHERE ja.company_id = 1;


-- This query gets all notes for one job application.
-- A useful index column is application_notes.application_id.
SELECT
    an.id AS note_id,
    an.content,
    ja.id AS application_id,
    ja.position
FROM job_applications ja
JOIN application_notes an ON an.application_id = ja.id
WHERE an.application_id = 10;

EXPLAIN
SELECT *
FROM job_applications
WHERE user_id = 2;