The scan type did not change. PostgreSQL used an Index Scan in both cases.

With the single-column index, only `user_id = 2` was included in `Index Cond`. The condition `status = 'INTERVIEW'` was applied as a separate filter.

The first plan returned 669 rows and removed 2,671 rows by the filter.

With the composite index, both `user_id = 2` and `status = 'INTERVIEW'` were included in `Index Cond`. The separate filter disappeared.

This means that PostgreSQL could search directly for the required combination instead of fetching all applications of the user and filtering most of them afterward.

The estimated row count was 668, while the actual row count was 669, so the planner estimate was very accurate.