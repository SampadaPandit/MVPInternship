/* 3. Query the Average Property Median Value by Suburb, and by Postcode separately, 
and then by Suburb and Postcode together. 
Then put Where condition to remove those records where there is no median value */

--1. Average by Suburb
SELECT 
    Suburb,
    AVG(Property_Median_Value) AS AvgMedianValue
FROM NSW_PropertyMedainValue
WHERE Property_Median_Value IS NOT NULL
GROUP BY Suburb
ORDER BY Suburb;

--2. Average by Postcode
SELECT 
    Postcode,
    AVG(Property_Median_Value) AS AvgMedianValue
FROM NSW_PropertyMedainValue
WHERE Property_Median_Value IS NOT NULL
GROUP BY Postcode
ORDER BY Postcode;

--3. Average by Suburb + Postcode together
SELECT 
    Suburb,
    Postcode,
    AVG(Property_Median_Value) AS AvgMedianValue
FROM NSW_PropertyMedainValue
WHERE Property_Median_Value IS NOT NULL
GROUP BY Suburb, Postcode
ORDER BY Suburb, Postcode;