/* --------------------------------------------------------------------------- */
-- QUESTION #2:
-- Look at the input data and write a query to transform it as the expected output.
select department, grade, salary
from (
		select department, grade,salary, 1 as orderSeq
		from employee_info
		union
		select department, 'All Grades', sum(salary),1 as orderSeq
		from employee_info
		group by department
		union
		select 'All Departments', grade, sum(salary),2 as orderSeq
		from employee_info
		group by grade
		union
		select 'All Departments', 'All Grades', sum(salary),2 as orderSeq
		from employee_info
		order by orderSeq, department, grade desc) x;
