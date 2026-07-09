# Day 14 — SQL Final Review Answers

## 1. What is the difference between INNER JOIN and LEFT JOIN?

`INNER JOIN` returns only rows where there is a match in both tables.

`LEFT JOIN` returns all rows from the left table and matching rows from the right table.

If there is no match in the right table, the right table columns will be `NULL`.

For example, `companies LEFT JOIN job_applications` keeps all companies, even companies without job applications.

---

## 2. Why do we use COUNT(ja.id) instead of COUNT(*) after LEFT JOIN?

We use `COUNT(ja.id)` instead of `COUNT(*)` after `LEFT JOIN` because `COUNT(*)` counts every returned row.

With `LEFT JOIN`, a company without job applications still appears in the result, but columns from `job_applications` are `NULL`.

`COUNT(*)` would count that row, but `COUNT(ja.id)` counts only rows where `ja.id` is not `NULL`.

So `COUNT(ja.id)` correctly returns `0` for companies without job applications.

---

## 3. What is the difference between WHERE and HAVING?

`WHERE` filters rows before grouping.

`HAVING` filters groups after `GROUP BY`.

We use `WHERE` for normal row conditions, for example `status = 'APPLIED'`.

We use `HAVING` for aggregate conditions, for example `COUNT(ja.id) > 1`.

---

## 4. What does GROUP BY do?

`GROUP BY` groups rows that have the same values in selected columns.

It allows us to calculate aggregate values for each group.

For example, `GROUP BY c.id, c.company_name` creates one group for each company, so we can count job applications separately for every company.

---

## 5. What does FILTER do inside aggregate functions?

`FILTER` applies a condition only to one aggregate function.

For example:

```sql
COUNT(ja.id) FILTER (WHERE ja.status = 'APPLIED')
```

counts only job applications with status `APPLIED`.

It does not filter the whole query. It only affects that specific `COUNT`.

---

## 6. What is a scalar subquery?

A scalar subquery is a query inside another query that returns exactly one value.

It must return one row and one column.

For example, a subquery with `AVG(salary_expectation)` returns one average value, so it can be used in a comparison.

---

## 7. What is the difference between IN and EXISTS?

`IN` compares a value with a list of values returned by a subquery.

`EXISTS` checks whether the subquery returns at least one matching row.

`IN` is focused on value comparison.

`EXISTS` is focused on checking if related rows exist.

---

## 8. What is the difference between NOT IN and NOT EXISTS?

`NOT IN` checks that a value is not present in a list returned by a subquery.

`NOT EXISTS` checks that no matching row exists in the subquery.

`NOT EXISTS` is usually safer when the subquery can return `NULL` values.

For example, to find companies without applications, `NOT EXISTS` checks that there is no job application where `ja.company_id = c.id`.

---

## 9. What is a correlated subquery?

A correlated subquery is a subquery that depends on the outer query.

It uses a value from the outer query inside the inner query.

For example, in this condition:

```sql
WHERE ja_inner.company_id = ja_outer.company_id
```

the inner query uses `ja_outer.company_id` from the outer query.

---

## 10. Explain this logic in your own words:

```text
companies LEFT JOIN job_applications + GROUP BY company + COUNT(ja.id)
```

This logic starts from the `companies` table, so all companies stay in the result.

Then `LEFT JOIN` attaches matching job applications to each company.

After that, `GROUP BY` creates one group for each company.

Finally, `COUNT(ja.id)` counts how many matching job applications each company has.

If a company has no job applications, `ja.id` is `NULL`, so `COUNT(ja.id)` returns `0`.

---

## 11. Explain this logic in your own words:

Find applications where `salary_expectation` is greater than the average `salary_expectation`.

First, the inner query calculates the average `salary_expectation` across all job applications.

Then the outer query checks each job application and returns only applications where `salary_expectation` is greater than that global average.

This is a scalar subquery because the inner query returns one value.

---

## 12. Explain this logic in your own words:

Find applications where `salary_expectation` is greater than the average `salary_expectation` inside the same company.

First, the outer query goes through job applications one by one.

For each application, the inner query calculates the average `salary_expectation` only for applications from the same company.

The inner query is connected to the outer query by `company_id`.

Then the outer query returns only applications where `salary_expectation` is greater than the average salary for that specific company.

This is a correlated scalar subquery because the inner query depends on the current row from the outer query.

---

## 13. Which SQL topic was the hardest for you and why?

The hardest SQL topic was subqueries, especially correlated subqueries.

They were harder because the inner query can depend on the outer query, so I need to be careful with aliases and with the connection between inner and outer rows.

For example, in a company average salary query, the inner query must be connected by `company_id`.

---

## 14. What SQL topics do you feel ready to use in a Spring Boot backend?

I feel ready to use basic SQL queries, filtering with `WHERE`, sorting with `ORDER BY`, joins, aggregations, `GROUP BY`, `HAVING`, and subqueries.

I also feel ready to write dashboard-style queries with `COUNT`, `AVG`, `FILTER`, and `LEFT JOIN`.

These topics are useful in a Spring Boot backend for repositories, reports, statistics, search filters, and admin dashboard endpoints.
