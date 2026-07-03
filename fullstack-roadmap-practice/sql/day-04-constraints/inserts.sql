INSERT INTO job_applications (
                              company_name,
                              position,
                              status,
                              salary_expectation,
                              vacancy_url )
VALUES
    ('SEB', 'Junior Java Developer', 'APPLIED', 1800, 'https://jobs.example.com/seb-java-junior'),
    ('Wise', 'Backend Developer', 'INTERVIEW', 2500, 'https://jobs.example.com/wise-backend'),
    ('Bolt', 'Java Trainee', 'REJECTED', 1500, 'https://jobs.example.com/bolt-java-trainee'),
    ('Swedbank', 'Junior Fullstack Developer', 'APPLIED', 2000, 'https://jobs.example.com/swedbank-fullstack'),
    ('LHV', 'Java Developer Intern', 'SAVED', 1200, 'https://jobs.example.com/lhv-java-intern'),
    ('Wolt', 'Software Developer', 'APPLIED', 2300, 'https://jobs.example.com/wolt-software'),
    ('Luminor', 'Junior Java Developer', 'INTERVIEW', 1900, 'https://jobs.example.com/luminor-java-junior');

INSERT INTO job_applications(
                             company_name,
                             position,
                             salary_expectation,
                             vacancy_url )
VALUES (
        'HELMES',
        'Java Developer',
        2100,
        'https://jobs.example.com/helmes-java'
       );