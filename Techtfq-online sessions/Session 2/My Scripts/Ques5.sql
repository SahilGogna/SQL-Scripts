/*
Write a query that'll identify returning active users.
A returning active user is a user that has made a second purchase within 7 days of any other of
their purchases. Output a list of user_ids of these returning active users.
*/
select distinct user_id
from (
		select user_id, created_at - previous_purchase as day_diff
		from (
				select user_id,created_at,LEAD(created_at) over(partition by user_id order by created_at desc) as previous_purchase 
				from amazon_transactions
		order by user_id, created_at desc) x) y
where y.day_diff < 7;