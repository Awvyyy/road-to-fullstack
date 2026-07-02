1. What does UPDATE do?

UPDATE changes existing rows in a table.
If we use WHERE, only the rows that match the condition will be updated.

2. What does DELETE do?

DELETE removes rows from a table.
If we use WHERE, only the rows that match the condition will be deleted.

3. Why is UPDATE without WHERE dangerous?

UPDATE without WHERE is dangerous because it updates every row in the table.

4. Why is DELETE without WHERE dangerous?

DELETE without WHERE is dangerous because it deletes every row from the table.

5. What does RETURNING * do?

RETURNING * returns all columns of the rows that were updated or deleted.
It helps us immediately see what was changed or removed.

6. Why is it better to update one application by id instead of company_name?

id is a primary key, so it uniquely identifies one row.
company_name is not unique, because we can have multiple job applications for the same company.
If we update by company_name, we may accidentally update several rows.

7. What will happen if we execute this query?
   UPDATE job_applications
   SET status = 'REJECTED';

This query will update every row in the job_applications table and set the status to REJECTED, because there is no WHERE condition.

8. What is the difference between SET salary_expectation = NULL and SET salary_expectation = 0?

NULL means that the value is unknown or missing.
0 is a real numeric value.

So NULL means “no value”, but 0 means “the salary expectation is zero”.

9. Why is it useful to run SELECT with the same WHERE before a massive DELETE?

It is useful because we can check which rows will be affected before deleting them.
This helps prevent accidental data loss.

10. What is safer for checking: first SELECT, then DELETE, or immediately DELETE?

It is safer to run SELECT first and then run DELETE.

First we check the rows with:

SELECT *
FROM job_applications
WHERE condition;

Then, if the result is correct, we run:

DELETE FROM job_applications
WHERE condition
RETURNING *;