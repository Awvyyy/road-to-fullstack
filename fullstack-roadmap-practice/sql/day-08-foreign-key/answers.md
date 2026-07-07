# Day 8 — Foreign Keys and Relationships

## 1. What is a FOREIGN KEY?

A **FOREIGN KEY** is a column in one table that references a **PRIMARY KEY** or another unique column in another table.

Example:

```sql
job_applications.user_id REFERENCES users(id)
```

In this example, `job_applications.user_id` is the foreign key, and `users.id` is the primary key it references.

A foreign key is not the primary key itself. It is a reference to a key from another table.

---

## 2. Why do we need a FOREIGN KEY?

A foreign key is needed to create a relationship between tables.

It also protects the database from invalid data. For example, it prevents creating a job application for a user that does not exist.

---

## 3. What happens if we insert a `user_id` that does not exist in `users`?

The database will return an error: **foreign key constraint violation**.

Example:

```sql
INSERT INTO job_applications (user_id, company_id, position, status)
VALUES (999, 1, 'Java Developer', 'APPLIED');
```

If there is no user with `id = 999` in the `users` table, PostgreSQL will reject this insert.

---

## 4. What is the difference between PRIMARY KEY and FOREIGN KEY?

A **PRIMARY KEY** uniquely identifies each row inside its own table.

A **FOREIGN KEY** stores a reference to a row from another table.

Example:

```text
users.id = PRIMARY KEY
job_applications.user_id = FOREIGN KEY
```

There can be one primary key constraint per table, but a table can have many foreign keys.

---

## 5. Why is `job_applications.user_id` a relationship with `users.id`?

Because each job application belongs to a specific user.

The `user_id` column in `job_applications` stores the `id` of the user from the `users` table.

Example:

```text
users
1 | helpned1@gmail.com

job_applications
1 | user_id = 1 | Software Developer
```

This means that the job application belongs to the user with `id = 1`.

---

## 6. Can one company have many job applications?

Yes.

One company can have many job applications.

Example:

```text
SEB -> Java Developer
SEB -> Backend Developer
SEB -> Trainee Java Developer
```

This is a one-to-many relationship:

```text
companies 1 -> many job_applications
```

---

## 7. Can one job application belong to two companies?

In the current database schema, no.

The `job_applications` table has only one `company_id` column:

```sql
company_id BIGINT REFERENCES companies(id)
```

This means that one job application can belong to only one company.

Correct model:

```text
one job application -> one company
one company -> many job applications
```

If one job application needed to belong to many companies, we would need an additional many-to-many table. But for this JobTracker project, one application should belong to one company.

---

## 8. Why should we not store only `company_name` in `job_applications`?

Because company names can repeat, change, or be written differently.

Bad example:

```text
SEB
Seb
seb bank
SEB Estonia
```

If we store only the company name in `job_applications`, we can easily get duplicated and inconsistent data.

A better solution is to store companies in a separate table and reference them by `company_id`.

Example:

```text
companies
1 | SEB

job_applications
1 | company_id = 1 | Software Developer
2 | company_id = 1 | Backend Developer
```

This keeps the database clean and consistent.
