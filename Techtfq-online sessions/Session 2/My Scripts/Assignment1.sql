/* There are 10 IPL team. write an sql query such that each team play with every other team just once. */
select home.team_name, away.team_name 
from teams home
cross join teams away
where home.team_code != away.team_code
order by home.team_name desc;

/*
This is a very poor method. Cross joins should only be preferred when the 
result generates only one value, or one of the table has only one value.
We will use inner join.
*/


select home.team_name, away.team_name 
from teams home
inner join teams away
on home.team_code != away.team_code
order by home.team_name desc;


