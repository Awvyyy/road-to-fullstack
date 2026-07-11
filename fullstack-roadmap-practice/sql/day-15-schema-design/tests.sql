-- 1. Пустой email
INSERT INTO users (email, password_hash)
VALUES ('   ', 'hash');

-- 2. Повторяющийся email
INSERT INTO users (email, password_hash)
VALUES ('test@example.com', 'hash1');

INSERT INTO users (email, password_hash)
VALUES ('test@example.com', 'hash2');

-- 3. Несуществующая компания
INSERT INTO job_applications (
    user_id,
    company_id,
    position,
    status
)
VALUES (
           1,
           999999,
           'Java Developer',
           'APPLIED'
       );

-- 4. Неправильный статус
INSERT INTO job_applications (
    user_id,
    company_id,
    position,
    status
)
VALUES (
           1,
           1,
           'Java Developer',
           'UNKNOWN'
       );

-- 5. Пустая заметка
INSERT INTO application_notes (application_id, content)
VALUES (1, '   ');

-- 6. Нулевая зарплата
INSERT INTO job_applications (
    user_id,
    company_id,
    position,
    status,
    salary_expectation
)
VALUES (
           1,
           1,
           'Java Developer',
           'APPLIED',
           0
       );