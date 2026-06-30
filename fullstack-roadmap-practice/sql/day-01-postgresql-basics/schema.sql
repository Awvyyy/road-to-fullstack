CREATE TABLE job_applications (
                                  id BIGSERIAL PRIMARY KEY,
                                  company_name VARCHAR(100) NOT NULL,
                                  position VARCHAR(100) NOT NULL,
                                  status VARCHAR(30) NOT NULL,
                                  salary_expectation INTEGER,
                                  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);