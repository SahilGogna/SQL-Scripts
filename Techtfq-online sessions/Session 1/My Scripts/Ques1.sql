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





















