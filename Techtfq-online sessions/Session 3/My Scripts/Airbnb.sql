-- QUESTION: Growth of Airbnb
/* Estimate the growth of Airbnb each year using the number of hosts registered as the growth metric.
The rate of growth is calculated by taking 
((number of hosts registered in the current year - number of hosts registered in the previous year) 
/ the number of hosts registered in the previous year) * 100.
Output the year, number of hosts in the current year, number of hosts in the previous year, and the rate of growth. Round the rate of growth to the nearest percent and order the result in the ascending order based on the year.
Assume that the dataset consists only of unique hosts, meaning there are no duplicate hosts listed.
*/

with year_counts as (
				select substring(host_since::varchar,1,4) as year, count(1) :: float as current_count,
				lag(count(1)) over(order by substring(host_since::varchar,1,4)) :: float as previous_count
				from airbnb_search_details
				group by year
				order by year)
select year, round(((current_count - previous_count)/previous_count)*100)
from year_counts;