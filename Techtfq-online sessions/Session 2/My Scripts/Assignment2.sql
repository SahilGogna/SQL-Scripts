/* Imagine you are given 2 tables, TAB1 and TAB2. Both have a single column A.
 And both tables have 3 records in them with value 1.
 What would the following joins (INNER Join, LEFT Join, RIGHT Join, FULL Outer Join,
 Cross Join and Natural Join) return? */

select * from tab1;
select * from tab2;

/*
1. INNER Join - table with 2 cols, each col has value 1, 9 rows
2. LEFT Join - table with 2 cols, each 1, 9 rows
3. RIGHT Join - table with 2 cols, each 1, 9 rows
4. FULL Outer Join - table with 2 cols, each 1, 9 rows
5. Cross Join - table with 2 cols, each 1, 9 rows
6. Natural Join - table with 1 col, each 1, 9 rows
*/
select * 
from tab1 
inner join tab2
on tab1.a = tab2.a;

select * 
from tab1 
left join tab2
on tab1.a = tab2.a;


select * 
from tab1 
right join tab2
on tab1.a = tab2.a;

select * 
from tab1 
full outer join tab2
on tab1.a = tab2.a;

select * 
from tab1 
cross join tab2;


select * 
from tab1 
natural join tab2;



