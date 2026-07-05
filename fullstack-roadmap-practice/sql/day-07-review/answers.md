# Day 07: SQL Basics Review

## 1. Why should we use `WHERE id = ...` when updating one row?

We should use `WHERE id = ...` when updating one row because without `WHERE`, PostgreSQL will update every row in the table.

Using `id` is safe because it identifies one specific row.

## 2. Why is `DELETE` without `WHERE` dangerous?

`DELETE` without `WHERE` is dangerous because it deletes all rows from the table.

That is why we should always check the target row before deleting and use a specific condition.

## 3. What is the difference between `WHERE` and `HAVING`?

`WHERE` filters individual rows before grouping.

`HAVING` filters grouped results after `GROUP BY`.

For example, `WHERE` can filter applications by status, and `HAVING` can filter statuses where `COUNT(*) > 1`.

## 4. What does `GROUP BY` do?

`GROUP BY` groups rows that have the same value in one or more columns.

It allows us to calculate aggregate values for each group, for example count applications by status.

## 5. What does `COUNT(*)` count?

`COUNT(*)` counts all rows returned by the query.

It includes rows even if some columns contain `NULL`.

## 6. Why does `COUNT(column)` ignore `NULL`?

`COUNT(column)` ignores `NULL` because `NULL` means missing or unknown value.

If we want to count all rows, we use `COUNT(*)`.

If we want to count only rows where a column has a value, we use `COUNT(column)`.

## 7. Why do we use constraints in database design?

We use constraints to protect the database from invalid data.

For example, `NOT NULL` prevents missing required values, `CHECK` validates allowed values, `UNIQUE` prevents duplicates, and `DEFAULT` provides a default value when no value is given.

## 8. What is the difference between `NULL` and `0`?

`0` is a real numeric value.

`NULL` means that the value is missing, unknown, or not provided.

For example, `salary_expectation = 0` means the value is zero, but `salary_expectation = NULL` means we do not know the value.

## 9. Why is `ORDER BY` important when using `LIMIT`?

`ORDER BY` is important when using `LIMIT` because the database does not guarantee row order without it.

If we use `LIMIT` without `ORDER BY`, we may get random or unpredictable rows.

## 10. What was the most difficult SQL topic so far?

The most difficult SQL topic so far was `HAVING`.

It was difficult because it is similar to `WHERE`, but it works after `GROUP BY` and filters grouped results.
