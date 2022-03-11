/* Find the popularity percentage for each user on Meta/Facebook.
The popularity percentage is defined as the total number of friends the user has divided by the
total number of users on the platform, then converted into a percentage by multiplying by 100.
Output each user along with their popularity percentage. Order records in ascending order by user id.
*/
with 
	all_users as (
				select user1 as users from facebook_friends
				union all
				select user2 as users from facebook_friends),
	distinct_users as(
				select count(distinct users)::numeric as total_users from all_users),
	friend_count as (
				select users, count(1)::numeric from all_users group by users)
select fc.users, round(fc.count/du.total_users*100,2) as percentage
from friend_count fc
cross join distinct_users du
order by percentage desc;





