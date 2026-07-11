# Day 15 — Schema Design Answers

## 1. Why does backend validation not replace database constraints?

Backend validation checks only the data that enters through the backend application.

However, data can also be inserted or changed through SQL scripts, migrations, database clients, tests, or other services.

Database constraints protect the data regardless of where the query comes from. Therefore, backend validation and database constraints should be used together.

---

## 2. What is the difference between `PRIMARY KEY` and `UNIQUE`?

A `PRIMARY KEY` is the main identifier of a row in a table.

It automatically requires the value to be both unique and not `NULL`. A table can have only one primary key, although that key can contain multiple columns.

A `UNIQUE` constraint only ensures that values in a column or group of columns do not repeat. A table can have multiple `UNIQUE` constraints.

In PostgreSQL, a normal `UNIQUE` constraint can allow multiple `NULL` values because `NULL` is not considered equal to another `NULL`.

---

## 3. Why does `DEFAULT` not replace `NOT NULL`?

`DEFAULT` provides a value when a column is omitted from an `INSERT` statement.

However, if the query explicitly provides `NULL`, the column will still contain `NULL` unless it also has a `NOT NULL` constraint.

Therefore, `DEFAULT` provides a fallback value, while `NOT NULL` guarantees that the column always contains a value.

---

## 4. Why is it better to store salary in `NUMERIC` instead of `FLOAT`?

`NUMERIC` stores decimal values with exact precision.

`FLOAT` stores an approximate binary representation, which can cause rounding errors.

For money and salary values, exact decimal calculations are important, so `NUMERIC` is safer and more appropriate.

---

## 5. What happens when `ON DELETE CASCADE` is used?

When a parent row is deleted, all related child rows are automatically deleted by the database.

For example, if a job application is deleted, its application notes can also be deleted automatically when the foreign key uses `ON DELETE CASCADE`.

---

## 6. Why is it dangerous to use `CASCADE` for `companies → job_applications`?

If a company is deleted, `ON DELETE CASCADE` would also delete every job application connected to that company.

This could accidentally destroy important application history.

For this relationship, `ON DELETE RESTRICT` is safer because it prevents the company from being deleted while related job applications still exist.

---

## 7. Why is `CASCADE` suitable for `job_applications → application_notes`?

An application note exists only in the context of a specific job application.

If the job application is deleted, its notes no longer have a useful parent record and should not remain in the database.

Therefore, deleting the notes automatically with `ON DELETE CASCADE` is appropriate.

---

## 8. What is the difference between `TIMESTAMP` and `TIMESTAMPTZ`?

`TIMESTAMP` stores a date and time without information about a time zone.

`TIMESTAMPTZ` represents a specific moment in time. PostgreSQL normalizes the value internally and displays it according to the current database session time zone.

`TIMESTAMPTZ` does not store the original time-zone name, but it helps avoid ambiguity when users or services operate in different time zones.

---

## 9. Can a column with `CHECK (salary_expectation > 0)` contain `NULL`?

Yes, it can contain `NULL`.

The expression `NULL > 0` produces `UNKNOWN`, not `FALSE`.

A `CHECK` constraint rejects a row only when its expression evaluates to `FALSE`. Therefore, the constraint allows `NULL` but rejects zero and negative values.

To forbid `NULL`, the column would also need a `NOT NULL` constraint.

---

## 10. Which rules should be checked by the database, and which belong only to application business logic?

The database should enforce permanent data-integrity rules, such as:

* primary keys;
* foreign keys;
* required fields with `NOT NULL`;
* unique values;
* valid status values;
* positive salary values;
* non-empty required text;
* safe deletion behavior between related rows.

The backend should enforce contextual business rules, such as:

* whether the current user is allowed to edit an application;
* whether a status transition is allowed;
* whether a user has the required role;
* whether an application can be submitted without an application date;
* which error message should be shown to the user.

Important business invariants can sometimes also be protected by the database, but authorization and user-specific workflow rules usually belong in the backend.
