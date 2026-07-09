# Day 13 — Subqueries Answers

## 1. What is a subquery?

A subquery is a query inside another query.

It can be used in `WHERE`, `IN`, `EXISTS`, or `FROM`.

Subqueries are useful when one query needs data calculated or selected by another query.

For example, we can use a subquery to find job applications where `salary_expectation` is greater than the average salary expectation.

---

## 2. What is a scalar subquery?

A scalar subquery is a subquery that returns exactly one value.

It must return one row and one column.

For example:

```sql
SELECT AVG(salary_expectation)
FROM job_applications;
```

This returns one value, so it can be used in a comparison:

```sql
WHERE salary_expectation > (
    SELECT AVG(salary_expectation)
    FROM job_applications
)
```

---

## 3. What is the difference between IN and EXISTS?

`IN` compares a value with a list of values returned by a subquery.

For example, `c.id IN (...)` checks if the company id exists in a list of company ids.

`EXISTS` checks whether the subquery returns at least one matching row.

`IN` is focused on comparing values.
`EXISTS` is focused on checking if related rows exist.

---

## 4. What is the difference between NOT IN and NOT EXISTS?

`NOT IN` checks that a value is not present in a list returned by a subquery.

`NOT EXISTS` checks that no matching row exists in the subquery.

`NOT EXISTS` is usually safer when the subquery can return `NULL` values.

For example, to find companies without applications, `NOT EXISTS` checks that there is no job application where `ja.company_id = c.id`.

---

## 5. What is a correlated subquery?

A correlated subquery is a subquery that depends on the outer query.

It uses a value from the outer query inside the inner query.

For example:

```sql
WHERE EXISTS (
    SELECT 1
    FROM job_applications ja
    WHERE ja.company_id = c.id
)
```

The inner query uses `c.id` from the outer query.

This means PostgreSQL checks the subquery separately for each company.

---

## 6. Why can NOT IN be dangerous when the subquery returns NULL?

`NOT IN` can be dangerous when the subquery returns `NULL` because comparisons with `NULL` are unknown.

For example:

```sql
WHERE id NOT IN (1, 2, NULL)
```

can return unexpected results because SQL cannot clearly decide if the value is not in a list that contains `NULL`.

Because of this, `NOT EXISTS` is often safer for finding rows without related records.

---

## 7. When would you use a subquery in FROM?

I would use a subquery in `FROM` when I need to build a temporary result first and then query from it.

For example, I can first count applications by company inside a subquery, and then in the outer query filter only companies where `application_count > 1`.

A subquery in `FROM` works like a temporary table and must have an alias.

---

## 8. Explain this logic in your own words:

Find applications where `salary_expectation` is greater than the average `salary_expectation`.

First, the inner query calculates the average `salary_expectation` from all job applications.

Then the outer query goes through job applications and returns only those where `salary_expectation` is greater than that average value.

This is an example of a scalar subquery because the inner query returns one value.

---

## 9. Explain this logic in your own words:

Find companies where `EXISTS` at least one job application.

The outer query starts from the `companies` table.

For each company, the `EXISTS` subquery checks if there is at least one row in `job_applications` where `ja.company_id = c.id`.

If such a row exists, the company is included in the result.

If no matching job application exists, the company is not included.

---

## 10. Which subquery type was the hardest for you and why?

The hardest subquery type was the correlated scalar subquery.

It was harder because the inner query depends on the outer query, and I need to correctly connect inner and outer aliases.

For example, when finding applications with salary above the company average, the inner query must calculate the average salary only for the same company:

```sql
WHERE ja_inner.company_id = ja_outer.company_id
```

If this connection is wrong, the query logic becomes incorrect.
