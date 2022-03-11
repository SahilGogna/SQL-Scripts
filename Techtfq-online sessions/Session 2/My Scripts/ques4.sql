select * from fb_eu_energy;
select * from fb_asia_energy;
select * from fb_na_energy;


/* Find the date with the highest total energy consumption from the Meta/Facebook data centers.
Output the date along with the total energy consumption across all data centers.
If there are multiple days with same highest energy consumption then display both dates.
*/
with 
		all_data as
		(select * from fb_eu_energy
			union all
			select * from fb_asia_energy
			union all
			select * from fb_na_energy),
		data_by_dates as(
			select te.date, sum(te.consumption) as total_energy
			from all_data te
			group by te.date
		)
select date,total_energy 
from data_by_dates
where total_energy = (select max(total_energy) from data_by_dates);


-- using rank function
with 
		all_data as
		(select * from fb_eu_energy
			union all
			select * from fb_asia_energy
			union all
			select * from fb_na_energy),
		data_by_dates as(
			select te.date, sum(te.consumption) as total_energy
			from all_data te
			group by te.date
		),
		ranked_data as(
			select date, total_energy, rank() over(order by total_energy desc)
			from data_by_dates
		)
select date, total_energy
from ranked_data
where rank = 1;











