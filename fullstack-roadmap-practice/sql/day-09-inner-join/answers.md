# Day 9 — INNER JOIN Answers

## 1. What does INNER JOIN do?

`INNER JOIN` returns only rows where matching records exist in both joined tables.

It connects related rows from different tables using a condition, usually between a foreign key and a primary key.

Example:

```sql
ON job_applications.company_id = companies.id
```

---

## 2. Why do we need JOIN in the JobTracker database?

We need `JOIN` in the JobTracker database because job applications store only `user_id` and `company_id`.

These ids are useful for the database, but not very readable for humans. With `JOIN`, we can show readable data, such as the user email and company name, together with the job application data.

For example, instead of seeing only:

```text
company_id = 1
user_id = 2
```

we can see:

```text
company_name = SEB
user_email = helpned2@gmail.com
```

---

## 3. What is the difference between `job_applications.company_id` and `companies.company_name`?

`job_applications.company_id` stores the id of the company connected to a job application.

`companies.company_name` stores the readable name of the company in the `companies` table.

Example:

```text
job_applications.company_id = 1
companies.company_name = SEB
```

The `company_id` is used to connect tables.
The `company_name` is used to display readable information.

---

## 4. Why should we use aliases like `ja`, `c`, and `u`?

Aliases make SQL code shorter and easier to read.

Instead of writing:

```sql
job_applications.position
```

we can write:

```sql
ja.position
```

Aliases also help avoid ambiguity when different tables have columns with the same name, such as `id` or `created_at`.

Example:

```sql
job_applications ja
companies c
users u
```

---

## 5. What does this condition mean?

```sql
ON ja.company_id = c.id
```

This condition means that PostgreSQL matches each job application with the company whose `id` is equal to the application’s `company_id`.

In other words:

```text
job_applications.company_id -> companies.id
```

For example, if a job application has:

```text
company_id = 1
```

PostgreSQL will find the company where:

```text
companies.id = 1
```

---

## 6. Why is `SELECT *` bad in JOIN queries?

`SELECT *` is bad in JOIN queries because joined tables often have columns with the same names, such as `id` or `created_at`.

It also returns unnecessary data and makes the result harder to read.

It is better to select only the columns we actually need.

Bad example:

```sql
SELECT *
FROM job_applications ja
INNER JOIN companies c ON ja.company_id = c.id;
```

Better example:

```sql
SELECT
    ja.id AS application_id,
    ja.position,
    ja.status,
    c.company_name
FROM job_applications ja
INNER JOIN companies c ON ja.company_id = c.id;
```

---

## 7. What happens if a job application has a `company_id` that does not exist in `companies`?

If the foreign key constraint exists, PostgreSQL will not allow this row to be inserted.

It will return a foreign key constraint violation error.

For example, if there is no company with `id = 999`, this insert should fail:

```sql
INSERT INTO job_applications (user_id, company_id, position, status)
VALUES (1, 999, 'Java Developer', 'APPLIED');
```

If invalid data already existed and we used `INNER JOIN`, that job application would not appear in the result because there would be no matching company row.

---

## 8. In your own words, explain this query:

```sql
SELECT
    ja.position,
    ja.status,
    c.company_name,
    u.email
FROM job_applications ja
INNER JOIN companies c ON ja.company_id = c.id
INNER JOIN users u ON ja.user_id = u.id;
```

This query gets job applications together with readable company and user information.

It starts from the `job_applications` table.

Then it joins the `companies` table using this condition:

```sql
ON ja.company_id = c.id
```

This gives us the company name.

Then it joins the `users` table using this condition:

```sql
ON ja.user_id = u.id
```

This gives us the user email.

As a result, we can see the job position, application status, company name, and user email in one result.
