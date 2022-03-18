-- QUESTION #9: Find the number of unique properties
/* Find how many the number of different property types in the dataset. 
here we have a column filter_room_types
*/

select trim(LEADING ',' from filter_room_types) from airbnb_searches;

SELECT distinct unnest(string_to_array(ltrim(filter_room_types,','),',')) prperty_types
FROM airbnb_searches;