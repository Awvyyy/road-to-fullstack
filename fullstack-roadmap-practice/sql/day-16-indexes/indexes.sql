CREATE INDEX idx_job_applications_user_id
    ON job_applications (user_id);

CREATE INDEX idx_job_applications_company_id
    ON job_applications (company_id);

CREATE INDEX idx_application_notes_application_id
    ON application_notes (application_id);

DROP INDEX idx_job_applications_user_id;