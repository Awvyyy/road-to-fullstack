1. What is table? <br>
Table is a database object, that contains data.

2. What is row? <br>
Row is a unique record in a table.

3. What is column? <br>
Columns define data type, that it can store.

4. Why we need Primary Key? <br>
Primary key makes every row in a table unique.

5. Why company_name can't be Primary key? <br>
Because we could have multiple rows with the same company name, but primary key must be unique for each row.

6. What "NOT NULL" does? <br>
NOT NULL says to the column, that it can't be empty.

7. What "BIGSERIAL" does? <br>
BIGSERIAL is a data type, that automatically creates a unique ID number, when creating a row.

8. What's the difference between "SELECT *" and "SELECT company_name, position" <br>
SELECT * - selects all data in the DB, SELECT company_name, position data only from columns: "company_name and position"

9. What "WHERE" does? <br>
It's some kind of filter, it pulls only the specific rows, that match the rules.

10. What "ORDER BY" does? <br>
ORDER BY - allows as to order data from a table. (e.g. order by name will give us order by names from letter A to Z)

11. What "LIMIT" does? <br>
Limits amount of rows, that the query will output.

12. Why we need to learn SQL, and not only Hibernate? <br>
SQL gives us opportunity to write our own queries to the DB. Also Hibernate is an ORM,
it means, that we don't write raw SQL, we operate the db with objects. 
