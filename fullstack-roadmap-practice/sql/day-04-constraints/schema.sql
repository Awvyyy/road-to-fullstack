DROP TABLE IF EXISTS job_applications;

CREATE TABLE job_applications
(
    id                 BIGSERIAL PRIMARY KEY,

    company_name       VARCHAR(100) NOT NULL,
    position           VARCHAR(100) NOT NULL,

    status             VARCHAR(30)  NOT NULL DEFAULT 'SAVED',

    salary_expectation INTEGER,

    vacancy_url        VARCHAR(500),

    created_at         TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT uq_job_applications_vacancy_url
        UNIQUE (vacancy_url),

    CONSTRAINT chk_job_applications_status
        CHECK (status IN ('SAVED', 'APPLIED', 'INTERVIEW', 'REJECTED')),

    CONSTRAINT chk_job_applications_salary_expectations
        CHECK (salary_expectation IS NULL OR salary_expectation >= 0)
);