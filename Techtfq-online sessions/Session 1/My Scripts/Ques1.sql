/* --------------------------------------------------------------------------- */
-- QUESTION #1 :- Salaries Differences
-- Credit: StrataScratch
-- Write a query that calculates the difference between the 
--highest salaries found in the marketing and engineering departments. 
-- Output just the absolute difference in salaries.

with 
	max_marketing_sal as (
						select max(salary) as sal
						from db_employee e
						join db_dept d
						on e.department_id = d.id
						where d.department = 'marketing'),
	max_eng_sal as (
					select max(salary) as sal
					from db_employee e
					join db_dept d
					on e.department_id = d.id
					where d.department = 'engineering')
select abs(ms.sal - es.sal)
from max_marketing_sal ms
cross join max_eng_sal es;

----------------------------------------
-- In method 1, we are using same query 2 times so this method reduced the number of queries

with 
	max_salaries as (
					select distinct max(e.salary) over(partition by d.department)as sal
					from db_employee e
					join db_dept d
					on e.department_id = d.id
					where d.department in ('engineering', 'marketing')
	)
select  distinct abs(eng_max.sal - mar_max.sal)
from max_salaries eng_max
cross join max_salaries mar_max
where eng_max.sal <> mar_max.sal;



















