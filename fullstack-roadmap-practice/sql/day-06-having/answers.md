# Day 06: SQL HAVING and Grouped Filtering

## 1. What does `HAVING` do?

`HAVING` filters grouped results after `GROUP BY`.

It is used when we need to filter groups based on aggregate values such as `COUNT(*)`, `AVG()`, `MIN()`, or `MAX()`.

For example:

```sql id="8bdaeb"
SELECT status, COUNT(*) AS applications_count
FROM job_applications
GROUP BY status
HAVING COUNT(*) > 1;
```

This query returns only statuses that have more than one job application.

## 2. What is the difference between `WHERE` and `HAVING`?

`WHERE` filters individual rows before grouping.

`HAVING` filters groups after `GROUP BY`.

Example:

```sql id="36ahzg"
SELECT status, COUNT(*) AS applications_count
FROM job_applications
WHERE salary_expectation IS NOT NULL
GROUP BY status
HAVING COUNT(*) > 1;
```

In this query:

1. `WHERE` removes rows where `salary_expectation` is `NULL`.
2. `GROUP BY` groups the remaining rows by `status`.
3. `HAVING` keeps only groups where the count is greater than `1`.

## 3. Can we use aggregate functions like `COUNT(*)` in `WHERE`? Why not?

No, we cannot use aggregate functions like `COUNT(*)` in `WHERE`.

`WHERE` is applied before `GROUP BY`, so groups and aggregate values do not exist yet at that stage.

Incorrect example:

```sql id="4u4wye"
SELECT status, COUNT(*)
FROM job_applications
WHERE COUNT(*) > 1
GROUP BY status;
```

This is invalid because `COUNT(*)` is calculated after grouping.

## 4. Can we use aggregate functions like `COUNT(*)` in `HAVING`?

Yes, we can use aggregate functions like `COUNT(*)` in `HAVING`.

`HAVING` is applied after `GROUP BY`, so aggregate values already exist.

Example:

```sql id="m8ypr2"
SELECT status, COUNT(*) AS applications_count
FROM job_applications
GROUP BY status
HAVING COUNT(*) > 1;
```

## 5. In what order are `WHERE`, `GROUP BY`, and `HAVING` applied?

The logical order is:

```text id="z2mkm9"
WHERE
GROUP BY
HAVING
```

First, `WHERE` filters rows.
Then, `GROUP BY` creates groups.
Finally, `HAVING` filters those groups.

## 6. Why is `HAVING` useful in JobTracker?

`HAVING` is useful in JobTracker because it allows us to filter statistics after grouping.

For example, we can find:

* statuses that have more than one application;
* companies that have more than one application;
* statuses where the average salary expectation is greater than `2000`;
* groups where the maximum or minimum salary matches some condition.

This helps us analyze job applications at a summary level, not just row by row.
