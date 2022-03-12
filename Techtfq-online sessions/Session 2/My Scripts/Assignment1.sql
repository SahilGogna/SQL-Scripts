/* There are 10 IPL team. write an sql query such that each team play with every other team just once. */
select home.team_name, away.team_name 
from teams home
cross join teams away
where home.team_code != away.team_code
order by home.team_name desc;