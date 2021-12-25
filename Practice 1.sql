-- blog for questions -> https://techtfq.com/blog/practice-writing-sql-queries-using-real-dataset


select * from olympics_history oh2 ;
select * from olympics_history_noc_regions ohnr ;
-- 1
select count(distinct(games)) from olympics_history oh ;

-- 2
select distinct oh.year,oh.season,oh.city
from olympics_history oh
order by year;

-- 3. Mention the total no of nations who participated in each olympics game?
with all_countries as
(select oh.games, nr.region
        from olympics_history oh
        join olympics_history_noc_regions nr ON nr.noc = oh.noc
        group by games, nr.region)
select games, count(1) as total_countries
from all_countries
group by games
order by games;

-- 4 Which year saw the highest and lowest no of countries participating in olympics
with all_countries as
(select oh.games, nr.region
        from olympics_history oh
        join olympics_history_noc_regions nr ON nr.noc = oh.noc
        group by games, nr.region),
        
        total_countries as (
        select games, count(1) as total_countries
		from all_countries
		group by games)
		
select max(total_countries)  MaxCountries, min(total_countries)  MinCountries
from total_countries;


'''Now in this question we will try to append the game year and namespace 
if we sort the table in asc order and then take the first value, Let us try to find first the min value
'''

with all_countries as
(select oh.games, nr.region
        from olympics_history oh
        join olympics_history_noc_regions nr ON nr.noc = oh.noc
        group by games, nr.region),
        
        total_countries as (
        select games, count(1) as total_countries
		from all_countries
		group by games)
		
select distinct 
concat(
first_value (games) over(order by(total_countries)),
' - ',
first_value (total_countries) over(order by(total_countries))
) as Lowest_Countries,

concat(
first_value (games) over(order by(total_countries) desc),
' - ',
first_value (total_countries) over(order by(total_countries) desc)
) as Maximum_Countries
from total_countries
order by 1;

'''
Major leanings:
1. When we order by the table values get arranged in asc, and when we use first_value function it selects the 
first value from the ordered table and sort of adds new column with the same value. That is the reason we need 
to use the distinct key word.

2. concat func is for string concatination
'''

--5 Which nation has participated in all of the olympic games?
-- 1. find all the olympic games
with 
    total_gam as 
		(select count(distinct(games)) as total_games from olympics_history),
	
	all_countries as
		(select oh.games, nr.region
        from olympics_history oh
        join olympics_history_noc_regions nr ON nr.noc = oh.noc
        group by games, nr.region),
        
    participated_games as
    	(select region, count(*) as c
    	from all_countries
    	group by region)
    	
select pg.region, tg.total_games
from participated_games pg
join total_gam tg 
on pg.c = tg.total_games;


-- 6. Identify the sport which was played in all summer olympics.
select * from olympics_history oh2 ;
with 
	total_summer_games as
	(select count(distinct(games)) as c
	from olympics_history oh
	where season like '%Summer%'
	),
	
	all_summer_sport as 
	(select distinct(games), sport 
	from olympics_history oh
	where season like '%Summer%'),
	
	count_each_game as 
	(select distinct (sport), count(*) as c 
	from all_summer_sport
	group by sport)

select *
from count_each_game cg
join total_summer_games ts 
on cg.c = ts.c;


-- 7. Which Sports were just played only once in the olympics.

with 
	all_year_game as 
	(select games, sport
	from olympics_history oh 
	group by sport, games
	order by games),
	
	sport_count_by_year as 
	(select sport, count(*) as c
	from all_year_game
	group by sport)

select * from 
sport_count_by_year
where c = 1
order by sport;

-- 8. Fetch the total no of sports played in each olympic games

with 
	all_year_game as 
	(select games, sport
	from olympics_history oh 
	group by sport, games
	order by games),
	
	total_sport_each_year as 
	(select games, count(*) as sport_count
	from all_year_game
	group by games)

select * from 
total_sport_each_year
order by games;

-- 9. Fetch oldest athletes to win a gold medal

with 
	temp as
	(select name, team, games,cast(case when age = 'NA' then '0' else age end as int) as age, medal
	from olympics_history oh),

    max_age_gold as
    (select max(age) as age from temp where medal = 'Gold')

select * from temp t
join max_age_gold mg
on t.age = mg.age
and medal = 'Gold'
order by name;

-- 10  Find the Ratio of male and female athletes participated in all olympic games.

with 
	males_count as 
	(select count(*) as cnt
	from olympics_history oh 
	where sex = 'M'),
	
	females_count as 
	(select count(*) as cnt
	from olympics_history oh 
	where sex = 'F')
	
select concat('1 : ', round(males_count.cnt::decimal/females_count.cnt, 2)) as ratio
from males_count, females_count;
	
	