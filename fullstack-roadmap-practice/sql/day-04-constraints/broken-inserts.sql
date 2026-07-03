INSERT INTO job_applications (
    company_name,
    position,
    status,
    salary_expectation,
    vacancy_url
)
VALUES (
           'Test Company',
           'Test Position',
           'BANANA',
           1000,
           'https://jobs.example.com/test-banana'
       );

/* violates check constraint (status can only be: SAVED, INTERVIEW, APPLIED, REJECTED) */

INSERT INTO job_applications (
    company_name,
    position,
    status,
    salary_expectation,
    vacancy_url
)
VALUES (
           'Bad Salary Company',
           'Bad Position',
           'APPLIED',
           -1000,
           'https://jobs.example.com/bad-salary'
       );

/* violates check constraint (salary can only be >= 0, negative not allowed) */

INSERT INTO job_applications (
    company_name,
    position,
    status,
    salary_expectation,
    vacancy_url
)
VALUES (
           NULL,
           'Java Developer',
           'APPLIED',
           2000,
           'https://jobs.example.com/null-company'
       );

/* violates NOT NULL constraint (company_name can't be NULL) */

INSERT INTO job_applications (
    company_name,
    position,
    status,
    salary_expectation,
    vacancy_url
)
VALUES (
           'Duplicate URL Company',
           'Java Developer',
           'APPLIED',
           2200,
           'https://jobs.example.com/seb-java-junior'
       );

/* violates UNIQUE constraint (vacancy_url must be unique) */
