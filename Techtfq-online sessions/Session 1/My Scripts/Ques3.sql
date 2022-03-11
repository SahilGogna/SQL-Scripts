/* --------------------------------------------------------------------------- */
-- QUESTION #3 :- Acceptance Rate By Date
-- What is the overall friend acceptance rate by date? 
-- Your output should have the rate of acceptances by the date the request was sent. 
-- Order by the earliest date to latest.
-- Assume that each friend request starts by a user sending (i.e., user_id_sender) a friend request to another user 
-- (i.e., user_id_receiver) that's logged in the table with action = 'sent'. If the request is accepted, 
-- the table logs action = 'accepted'. If the request is not accepted, no record of action = 'accepted' is logged.


select sent.date, count(1)::float as tot_accept
		from fb_friend_requests sent
		join fb_friend_requests accept on sent.user_id_sender = accept.user_id_sender
		where sent.action='sent'
		and accept.action='accepted'
		group by sent.date