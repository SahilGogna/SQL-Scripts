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

