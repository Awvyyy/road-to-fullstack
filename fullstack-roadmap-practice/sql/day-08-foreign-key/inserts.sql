INSERT INTO users (email, password_hash)
VALUES ('helpned1@gmail.com', 'adwadad123ad2-1231ad'),
       ('helpned2@gmail.com', '12312-adawda');

INSERT INTO companies ( company_name, website)
VALUES ('SEB', 'www.seb.com'),
        ('Swedbank', 'www.swedbank.com'),
        ('LHV', 'www.lhv.com');

INSERT INTO job_applications (user_id, company_id, position, status, salary_expectation)
VALUES (1, 1, 'Software Developer', 'APPLIED', 3500),
       (2, 2, 'Junior Java Developer', 'SAVED', 2400),
       (1, 2, 'Java Developer', 'INTERVIEW', 2150),
       (2,1, 'Senior Java/Spring Developer', 'SAVED', 4500),
       (2, 2, 'VP Java Developer', 'REJECTED', 7500);