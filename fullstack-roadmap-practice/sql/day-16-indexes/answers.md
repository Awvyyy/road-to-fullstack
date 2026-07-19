# Day 16 — PostgreSQL Index Basics Answers

## 1. What is an index?

An index is a separate data structure that stores values from one or more table columns together with references to the related table rows.

It is similar to the table of contents in a book. Instead of reading every page to find a chapter, we can use the table of contents to find its location faster.

---

## 2. Why does an index make searching faster?

Without an index, PostgreSQL may need to check table rows one by one.

With an index, PostgreSQL can search the index first, find references to matching rows, and then fetch only those rows from the table.

For example, an index on `job_applications.user_id` can help PostgreSQL quickly find all applications that belong to one user.

---

## 3. Where is index data stored?

Index data is stored separately from the table rows.

The index contains indexed values and references to table rows. It is not stored inside each table row.

Because it is a separate database object, an index also occupies disk space and must be maintained when table data changes.

---

## 4. Which constraints create indexes automatically in PostgreSQL?

PostgreSQL automatically creates indexes for:

- `PRIMARY KEY`;
- `UNIQUE`.

In this project, PostgreSQL automatically created primary key indexes for all four tables and a unique index for `users.email`.

---

## 5. Does PostgreSQL automatically create an index for a foreign key?

No.

PostgreSQL creates an index on the referenced parent column when that column is a primary key or unique, but it does not automatically create an index on the foreign key column in the child table.

For example, `users.id` is indexed because it is a primary key, but `job_applications.user_id` needs a separate manually created index.

---

## 6. Under which query is the index on `job_applications.user_id` useful?

It is useful for queries that search for all job applications of one user.

For example:

```sql
SELECT *
FROM job_applications
WHERE user_id = 2;
```

It can also help joins that connect `users.id` with `job_applications.user_id`.

---

## 7. Why must indexes on `user_id`, `company_id`, and `application_id` not be `UNIQUE`?

These columns are on the many side of one-to-many relationships.

One user can have many job applications, one company can have many job applications, and one job application can have many notes.

If these indexes were unique:

- one user could have only one job application;
- one company could have only one job application;
- one job application could have only one note.

That would incorrectly change the relationships into one-to-one relationships.

---

## 8. Why can an index on `status` be useless?

The `status` column has only five possible values:

- `SAVED`;
- `APPLIED`;
- `INTERVIEW`;
- `OFFER`;
- `REJECTED`.

One status can belong to a large part of the table. For example, `APPLIED` could belong to 60% of all rows.

In that case, PostgreSQL may decide that reading the whole table with a sequential scan is cheaper than reading many index entries and then fetching many rows from the table.

Therefore, an index on `status` is not always useful.

---

## 9. What is selectivity?

Selectivity describes how much a condition reduces the number of returned rows.

A highly selective condition returns only a small part of the table.

Example:

```sql
WHERE email = 'test@example.com'
```

A low-selectivity condition returns a large part of the table.

Example:

```sql
WHERE status = 'APPLIED'
```

The fewer rows a condition returns, the more useful an index can be.

---

## 10. Why can PostgreSQL choose a sequential scan even when an index exists?

PostgreSQL chooses the plan that it estimates to be cheaper.

It can choose a sequential scan when:

- the table is small;
- the condition returns a large part of the table;
- using the index would require many jumps from the index to table rows;
- statistics show that reading the table directly is cheaper.

The existence of an index does not guarantee that PostgreSQL will use it.

---

## 11. How do indexes affect `INSERT`, `UPDATE`, and `DELETE`?

Indexes make write operations more expensive.

For `INSERT`, PostgreSQL must insert the row into the table and add entries to all related indexes.

For `UPDATE`, PostgreSQL may need to update index entries when indexed values change.

For `DELETE`, PostgreSQL must remove the related entries from indexes.

Therefore, many indexes can slow down write operations.

---

## 12. Why should we not create an index for every column?

Every index:

- occupies additional disk space;
- increases the cost of `INSERT`;
- can increase the cost of `UPDATE`;
- can increase the cost of `DELETE`;
- requires maintenance;
- can be useless if the column has low selectivity;
- may never be used by important queries.

Indexes should be created for real and important query patterns, not just because a column exists.

---

## 13. What is the difference between `EXPLAIN` and `EXPLAIN ANALYZE`?

`EXPLAIN` shows PostgreSQL's estimated query plan without executing the query.

`EXPLAIN ANALYZE` executes the query and shows the real execution statistics, including actual timing and actual row counts.

This is important for data-changing queries because:

```sql
EXPLAIN ANALYZE DELETE ...
```

will really execute the deletion.

---

## 14. Why is an index on `company_id` useful for foreign key operations?

The relationship is:

```text
job_applications.company_id -> companies.id
```

and it uses `ON DELETE RESTRICT`.

Before deleting a company, PostgreSQL must check whether any rows in `job_applications` reference that company.

Without an index on `job_applications.company_id`, PostgreSQL may need to perform a sequential scan of the child table.

The index helps PostgreSQL find related job applications faster and quickly decide whether the deletion must be blocked.

---

## 15. Why would a separate index on `users.id` be unnecessary?

`users.id` is a primary key.

PostgreSQL automatically created a unique B-tree index for this column.

Creating another index on the same column would duplicate the existing index, occupy extra space, and add unnecessary maintenance costs.

---

## 16. How can we tell that an index was created for a real need?

Before creating an index, we should be able to answer:

1. Which concrete query should this index improve?
2. Is the query important and executed frequently?
3. Is the table large enough for the index to matter?
4. Does the condition return a relatively small part of the table?
5. Does `EXPLAIN` show that the index can be useful?
6. Is the read performance improvement worth the extra write and disk costs?

If we cannot name a real query for an index, it is probably being created “just in case”.

---

# Existing indexes

The following indexes were created automatically by PostgreSQL because of primary keys:

```text
application_notes_pkey
companies_pkey
job_applications_pkey
users_pkey
```

The following index was created automatically because of the `UNIQUE` constraint on `users.email`:

```text
users_email_key
```

The following indexes were created manually:

```text
idx_job_applications_user_id
idx_job_applications_company_id
idx_application_notes_application_id
```

No additional index is needed for primary key columns or `users.email`, because PostgreSQL already created those indexes automatically.

---

# Status index analysis

There are five possible status values.

One status can belong to a large part of the table. Therefore, an index on `status` is not always useful.

Low selectivity means that a condition matches many rows. In that case, PostgreSQL would need to read many index entries and then fetch many rows from the table. A sequential scan can be cheaper.

I should not create an index on `status` yet because I do not have enough evidence that it improves an important query. The decision should be based on real data distribution and query plans.

---

# Foreign key index analysis

Before deleting a company, PostgreSQL must check whether any rows in `job_applications` reference that company through `company_id`.

Without an index on `job_applications.company_id`, PostgreSQL may need to perform a sequential scan of the child table.

The index allows PostgreSQL to find related job applications faster and quickly determine whether `ON DELETE RESTRICT` should prevent the deletion.

The primary key index on `companies.id` helps PostgreSQL find the company itself, but it does not help find rows in the child table. Therefore, the foreign key column in `job_applications` needs its own index.

---

# Query plan comparison on a small table

The `job_applications` table initially contained only 10 rows.

Without the index, PostgreSQL used a sequential scan:

```text
Seq Scan on job_applications
  Filter: (user_id = 2)
```

After creating the index, PostgreSQL still used a sequential scan.

The table was very small, so reading all 10 rows was cheaper than opening the index and then fetching matching rows from the table.

This did not mean that the index was broken. PostgreSQL was free to ignore the index when a sequential scan was estimated to be cheaper.

---

# Query plan comparison on a larger table

The `job_applications` table contained 10,010 rows.

The rows were distributed between users approximately evenly:

```text
user 2: 3,340 applications
user 4: 3,337 applications
user 5: 3,333 applications
```

Without the index, PostgreSQL used a sequential scan:

```text
Seq Scan on job_applications
  Filter: (user_id = 2)
```

After creating `idx_job_applications_user_id`, PostgreSQL used an index scan:

```text
Index Scan using idx_job_applications_user_id on job_applications
  Index Cond: (user_id = 2)
```

On the small table PostgreSQL preferred a sequential scan. After the table grew to more than 10,000 rows, it estimated that using the index was cheaper.

This demonstrates that PostgreSQL chooses a query plan based on table size, data distribution, statistics, and estimated cost. The existence of an index does not always guarantee that it will be used.