# Day 05: SQL Aggregation Basics

## 1. What does `COUNT(*)` do?

`COUNT(*)` counts all rows returned by the query.

For example, if the `job_applications` table has 8 rows, `COUNT(*)` will return `8`.

## 2. What does `GROUP BY` do?

`GROUP BY` groups rows that have the same value in one or more columns.

For example, if we group by `status`, PostgreSQL will create separate groups for statuses like `APPLIED`, `INTERVIEW`, `SAVED`, and `REJECTED`.

## 3. What is the difference between `COUNT(*)` and `COUNT(salary_expectation)`?

`COUNT(*)` counts all rows.

`COUNT(salary_expectation)` counts only rows where `salary_expectation` is not `NULL`.

So if a row has `salary_expectation = NULL`, it will be counted by `COUNT(*)`, but it will not be counted by `COUNT(salary_expectation)`.

## 4. What does `AVG()` do?

`AVG()` calculates the average value of a numeric column.

For example, `AVG(salary_expectation)` calculates the average salary expectation.

## 5. Why does `AVG(salary_expectation)` ignore `NULL` values?

`AVG(salary_expectation)` ignores `NULL` values because `NULL` means unknown or missing value.

PostgreSQL cannot use an unknown value in a numeric average calculation.

## 6. Why do we need aggregation in JobTracker?

We need aggregation in JobTracker to get useful statistics about job applications.

For example, we can calculate:

* total number of applications;
* number of applications by status;
* average salary expectation;
* minimum and maximum salary expectation;
* number of applications for each company.

Aggregation helps us understand the job search progress instead of looking at every row manually.

## 7. What is the difference between `WHERE` and `GROUP BY`?

`WHERE` filters rows before aggregation.

`GROUP BY` groups rows so we can calculate aggregated values for each group.

For example:

```sql
SELECT status, COUNT(*)
FROM job_applications
WHERE salary_expectation IS NOT NULL
GROUP BY status;
```

In this query, `WHERE` first removes rows where `salary_expectation` is `NULL`, and then `GROUP BY` groups the remaining rows by `status`.
