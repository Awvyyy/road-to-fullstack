1. What's the difference between AND & OR? <br>
"AND" means, that both rules must be correct, while "OR" means, that at least 1 rule must be completed.

2. When do we have to use "IN" instead of "OR"? <br>
When we compare 1 column with multiple possible values.

3. What does "%Java%" means in "LIKE"? <br>
"%Java%" means, that before or after word "Java" can be symbols/letters/text.

4. What's the difference between LIKE 'Java%' and LIKE '%Java%'? <br>
In the first case we can't have symbols/letters/text before word Java, in the second case we can.

5. What does "IS NULL" does? <br>
IS NULL checks whether a column has no value.

6. Why cant we write "= NULL"? <br>
NULL is unknown or missing. 

7. Why can't we guarantee order without "ORDER BY"? <br>
The database can return rows in any order, depending on indexes, internal optimizations & etc...