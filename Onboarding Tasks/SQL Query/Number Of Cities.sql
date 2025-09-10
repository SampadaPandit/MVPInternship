--1. Find out the number of cities in each state.
SELECT 
	PostSuburb.state, 
	COUNT(DISTINCT PostSuburb.city) AS NumberOfCities
FROM 
	AUS_Post_suburb PostSuburb
GROUP BY state
ORDER BY state;