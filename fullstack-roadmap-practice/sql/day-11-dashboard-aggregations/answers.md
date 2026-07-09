# Day 11 — Dashboard Aggregations Answers

## 1. Why do we use COUNT(ja.id) instead of COUNT(*) with LEFT JOIN?

We use `COUNT(ja.id)` instead of `COUNT(*)` with `LEFT JOIN` because `COUNT(*)` counts every row returned by the query.

With `LEFT JOIN`, a company without job applications still appears in the result. In that case, columns from `job_applications` are `NULL`.

`COUNT(*)` would count that row and return `1`, but `COUNT(ja.id)` counts only rows where `ja.id` is not `NULL`.

So `COUNT(ja.id)` correctly returns `0` for companies without job applications.

---

## 2. Why do we start from companies when counting applications by company?

We start from `companies` because we want to keep all companies in the result.

If a company has job applications, we count them.
If a company has no job applications, the company still appears in the result with `0` applications.

This is useful for a dashboard because we do not want to hide companies without applications.

---

## 3. What does GROUP BY c.id, c.company_name do?

`GROUP BY c.id, c.company_name` creates one group for each company.

This allows PostgreSQL to calculate aggregate values, such as `COUNT(ja.id)`, separately for every company.

We group by both `c.id` and `c.company_name` because `id` uniquely identifies the company, while `company_name` is readable for humans.

---

## 4. What does FILTER do in aggregate functions?

`FILTER` applies a condition only to a specific aggregate function.

For example:

```sql
COUNT(ja.id) FILTER (WHERE ja.status = 'APPLIED')
```

counts only applications with status `APPLIED`.

It does not remove other rows from the whole query. It only affects that specific `COUNT`.

---

## 5. What is the difference between WHERE and FILTER?

`WHERE` filters rows for the whole query before grouping and aggregation.

`FILTER` filters rows only inside one aggregate function.

For example, `WHERE ja.status = 'APPLIED'` keeps only `APPLIED` rows in the whole query.

But `COUNT(ja.id) FILTER (WHERE ja.status = 'APPLIED')` counts only `APPLIED` applications while still allowing other aggregate counts, such as `SAVED`, `INTERVIEW`, and `REJECTED`, in the same result.

---

## 6. Why is this useful for a JobTracker dashboard?

This is useful for a JobTracker dashboard because we can show summary statistics instead of raw rows.

For example, we can show how many applications each company has, how many applications each user has, and how many applications are in each status.

We can also show companies with zero applications, which is useful for understanding missing activity.

---

## 7. Why can AVG(ja.salary_expectation) return NULL for some companies?

`AVG(ja.salary_expectation)` can return `NULL` when a company has no matching job applications.

It can also return `NULL` when all `salary_expectation` values for that company are `NULL`.

Aggregate functions like `AVG` ignore `NULL` values. If there are no non-NULL values to calculate, the result is `NULL`.

---

## 8. Explain this logic in your own words:

```text
companies LEFT JOIN job_applications + GROUP BY company + COUNT(ja.id)
```

This logic starts from the `companies` table, so all companies stay in the result.

Then it uses `LEFT JOIN` to attach matching job applications to each company.

After that, `GROUP BY` groups the result by company, so each company becomes one group.

Finally, `COUNT(ja.id)` counts how many job applications were found for each company.

If a company has no job applications, `ja.id` is `NULL`, so `COUNT(ja.id)` returns `0`.
