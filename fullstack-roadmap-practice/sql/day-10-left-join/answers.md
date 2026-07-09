# Day 10 — LEFT JOIN Answers

## 1. What does LEFT JOIN do?

`LEFT JOIN` returns all rows from the left table and matching rows from the right table.

If there is no matching row in the right table, PostgreSQL returns `NULL` for the right table columns.

---

## 2. What is the main difference between INNER JOIN and LEFT JOIN?

`INNER JOIN` returns only rows where matching records exist in both tables.

`LEFT JOIN` returns all rows from the left table, even if there is no matching record in the right table.

If there is no match, the columns from the right table will contain `NULL`.

---

## 3. In this query, which table is the left table?

```sql
FROM companies c
LEFT JOIN job_applications ja ON c.id = ja.company_id
```

The left table is `companies`.

It is the table after `FROM`, so `LEFT JOIN` keeps all rows from `companies`.

---

## 4. Why can LEFT JOIN return rows with NULL values?

`LEFT JOIN` can return `NULL` values because some rows from the left table may not have matching rows in the right table.

For example, if a company has no job applications, PostgreSQL still returns the company, but the columns from `job_applications` will be `NULL`.

---

## 5. How can we find companies without job applications?

We can use `LEFT JOIN` from `companies` to `job_applications` and then filter rows where the job application was not found.

Example:

```sql
SELECT
    c.id AS company_id,
    c.company_name
FROM companies c
LEFT JOIN job_applications ja ON c.id = ja.company_id
WHERE ja.id IS NULL;
```

`ja.id IS NULL` means that there is no matching job application for this company.

---

## 6. Why can `WHERE ja.status = 'APPLIED'` break the idea of LEFT JOIN?

`WHERE ja.status = 'APPLIED'` can break the idea of `LEFT JOIN` because it removes rows where `ja.status` is `NULL`.

Rows with `NULL` appear when there is no matching row in the right table.

So if we put this condition in `WHERE`, companies without matching applications will disappear from the result. In this case, the query becomes similar to an `INNER JOIN`.

---

## 7. Why should we put the `ja.status = 'APPLIED'` filter inside ON in some LEFT JOIN queries?

We should put the `ja.status = 'APPLIED'` filter inside `ON` when we want to keep all rows from the left table.

Example:

```sql
SELECT
    c.company_name,
    ja.position,
    ja.status
FROM companies c
LEFT JOIN job_applications ja
    ON c.id = ja.company_id
   AND ja.status = 'APPLIED';
```

This query keeps all companies.

If a company has an `APPLIED` application, PostgreSQL shows it.
If a company does not have an `APPLIED` application, PostgreSQL still shows the company, but the job application columns will be `NULL`.

---

## 8. Why do we use LEFT JOIN from companies to job_applications instead of from job_applications to companies?

We use `LEFT JOIN` from `companies` to `job_applications` because we want to keep all companies in the result.

This allows us to see companies that have applications and companies that do not have applications.

If we start from `job_applications` and left join `companies`, we keep all job applications, not all companies. In our schema, every job application must have a company, so this direction is less useful for finding companies without applications.

---

## 9. Explain this query in your own words:

```sql
SELECT
    c.company_name,
    ja.position,
    ja.status
FROM companies c
LEFT JOIN job_applications ja ON c.id = ja.company_id;
```

This query returns all companies and their job applications.

It starts from the `companies` table, so every company will appear in the result.

If a company has job applications, PostgreSQL shows the application position and status.
If a company has no job applications, PostgreSQL still shows the company, but `position` and `status` will be `NULL`.

---

## 10. Explain this query in your own words:

```sql
SELECT
    c.company_name
FROM companies c
LEFT JOIN job_applications ja
    ON c.id = ja.company_id
WHERE ja.id IS NULL;
```

This query finds companies without job applications.

It starts from the `companies` table and tries to find matching rows in `job_applications`.

If no matching job application is found, `ja.id` will be `NULL`.

The condition `WHERE ja.id IS NULL` keeps only companies that do not have any job applications.
