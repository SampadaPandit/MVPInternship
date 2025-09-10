--2. Find out the number of unique postcodes, and suburbs in each city .
SELECT 
    PostSuburb.city,
    COUNT(DISTINCT PostSuburb.postcode) AS UniquePostcodes,
    COUNT(DISTINCT PostSuburb.suburb) AS UniqueSuburbs
FROM AUS_Post_suburb PostSuburb
GROUP BY city
ORDER BY city;