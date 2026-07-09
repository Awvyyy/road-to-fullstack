# Day 12 — HAVING with JOINs Answers

## 1. What does HAVING do?

`HAVING` filters grouped results after `GROUP BY`.

It is used when we need to filter groups based on aggregate values, such as `COUNT`, `AVG`, `MIN`, or `MAX`.

For example, we can use `HAVING COUNT(ja.id) > 1` to return only companies that have more than one job application.

---

## 2. What is the difference between WHERE and HAVING?

`WHERE` filters individual rows before grouping.

`HAVING` filters groups after `GROUP BY`.

For example, `WHERE ja.status = 'APPLIED'` filters rows before aggregation.

`HAVING COUNT(ja.id) > 1` filters already grouped results after PostgreSQL has counted the applications.

---

## 3. Why can we use COUNT(...) in HAVING but not in WHERE?

We can use `COUNT(...)` in `HAVING` because `HAVING` is executed after `GROUP BY`.

At that point, groups already exist and aggregate values like `COUNT`, `AVG`, `MIN`, and `MAX` have been calculated.

We cannot use `COUNT(...)` in `WHERE` because `WHERE` is executed before grouping, so aggregate values do not exist yet.

---

## 4. Why should we use COUNT(ja.id) instead of COUNT(*) with LEFT JOIN?

We should use `COUNT(ja.id)` instead of `COUNT(*)` with `LEFT JOIN` because `COUNT(*)` counts every result row.

With `LEFT JOIN`, a company without job applications still appears in the result. In that row, columns from `job_applications` are `NULL`.

`COUNT(*)` would count that row and return `1`.

`COUNT(ja.id)` counts only rows where `ja.id` is not `NULL`, so it correctly returns `0` for companies or users without job applications.

---

## 5. What does this condition mean?

```sql
HAVING COUNT(ja.id) = 0
```

This condition means that after grouping, PostgreSQL keeps only groups where no matching job applications were found.

For example, if we group by company, this condition returns companies with zero job applications.

---

## 6. What does this condition mean?

```sql
HAVING COUNT(ja.id) FILTER (WHERE ja.status = 'APPLIED') > 0
```

This condition means that PostgreSQL keeps only groups where there is at least one job application with status `APPLIED`.

`FILTER` applies only to this specific `COUNT`, so it counts only applications with the `APPLIED` status.

---

## 7. Why can AVG(ja.salary_expectation) return NULL after LEFT JOIN?

`AVG(ja.salary_expectation)` can return `NULL` after `LEFT JOIN` when there are no matching job applications.

It can also return `NULL` when all `salary_expectation` values in the group are `NULL`.

Aggregate functions like `AVG` ignore `NULL` values. If there are no non-NULL values to calculate, the result is `NULL`.

---

## 8. Explain this logic in your own words:

```text
companies LEFT JOIN job_applications + GROUP BY company + HAVING COUNT(ja.id) > 1
```

This logic starts from the `companies` table, so all companies are included before filtering.

Then `LEFT JOIN` attaches matching job applications to each company.

After that, `GROUP BY` creates one group for each company.

`COUNT(ja.id)` counts how many job applications each company has.

Finally, `HAVING COUNT(ja.id) > 1` keeps only companies that have more than one job application.
