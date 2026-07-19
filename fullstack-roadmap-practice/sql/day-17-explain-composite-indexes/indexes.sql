CREATE INDEX idx_job_applications_user_id_status ON job_applications(user_id, status);

DROP INDEX idx_job_applications_user_id_status;