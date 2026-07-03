1. What does CHECK do?

CHECK validates data before inserting or updating a row.
If the condition is false, PostgreSQL rejects the operation.

2. Why do we restrict status values?

We restrict status values to prevent invalid data.
For example, statuses like BANANA or UNKNOWN should not be allowed in the job_applications table.

3. What does DEFAULT do?

DEFAULT provides an automatic value when we do not specify a column during INSERT.

4. What status will be used if we do not provide status during insert?

The status will be SAVED, because the status column has DEFAULT 'SAVED'.

5. Why should salary_expectation not be negative?

Salary expectation should not be negative because negative salary is invalid business data.

6. Why do we allow salary_expectation IS NULL?

We allow salary_expectation IS NULL because sometimes we do not know the expected salary yet.
NULL means unknown or missing value.

7. What does UNIQUE do?

UNIQUE prevents duplicate values in a column or a group of columns.

8. Why do we use UNIQUE for vacancy_url?

We use UNIQUE for vacancy_url because the same vacancy link should not be saved twice.

9. What does DROP TABLE IF EXISTS do?

DROP TABLE IF EXISTS deletes the table if it already exists.
If the table does not exist, PostgreSQL does not throw an error.

10. Why is DROP TABLE IF EXISTS useful during learning, but dangerous in production?

It is useful during learning because we can easily recreate the table from scratch.
It is dangerous in production because it deletes the table and all its data.

11. What happens if we try to insert status = 'BANANA'?

PostgreSQL rejects the insert because BANANA does not pass the CHECK constraint for the status column.

12. What happens if we try to insert salary_expectation = -1000?

PostgreSQL rejects the insert because negative salary does not pass the salary expectation CHECK constraint.

13. What happens if we try to insert duplicate vacancy_url?

PostgreSQL rejects the insert because vacancy_url must be unique.

14. Why are database constraints important even if we have validation in Java?

Database constraints protect data at the database level.
Java validation protects only one application, but data can also be inserted through SQL scripts, imports, pgAdmin, migrations, or another service.