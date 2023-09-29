-- Pulling Up Both Tables for the Project

SELECT *
FROM dbo.EconomicInequality$

SELECT *
FROM dbo.gdppercapita

-- Arranging Countries by Highest Income Shares of the Richest 10% of the Population

SELECT Country, MAX([Income_Share_of_the_Richest_TenPercent_Pre-Tax]) AS Income_Share_RichestTenPercent
FROM dbo.EconomicInequality$
WHERE [Income_Share_of_the_Richest_TenPercent_Pre-Tax] != 'NULL'
GROUP BY Country
ORDER BY Country

-- Arranging Countries by Highest Income Shares of the Richest 1% of the Population

SELECT Country, MAX([Income_Share_of_the_Richest_OnePercent_Pre-Tax]) AS Income_Share_RichestOnePercent
FROM dbo.EconomicInequality$
WHERE [Income_Share_of_the_Richest_OnePercent_Pre-Tax] != 'NULL'
GROUP BY Country
ORDER BY Country

-- Arranging Countries by Highest Income Shares of the Richest 0.1% of the Population

SELECT Country, MAX([Income_Share_of_the_Richest_ZeroPointOnePercent_Pre-Tax]) AS Income_Share_RichestZeroPointOnePercent
FROM dbo.EconomicInequality$
WHERE [Income_Share_of_the_Richest_ZeroPointOnePercent_Pre-Tax] != 'NULL'
GROUP BY Country
ORDER BY Country

-- Arranging Countries by Worst Distribution of Wealth to Latter 50% of the Population

SELECT Country, MAX([Income_Share_of_the_Poorest_FiftyPercent_Pre-Tax]) AS Income_Share_PoorestFiftyPercent
FROM dbo.EconomicInequality$
WHERE [Income_Share_of_the_Poorest_FiftyPercent_Pre-Tax] != 'NULL'
GROUP BY Country
ORDER BY MAX([Income_Share_of_the_Poorest_FiftyPercent_Pre-Tax])

-- Beacon of Capitalism: Analyzing USA's Distribution of Wealth Through The Years (Excluding NULLs)

SELECT Country, Year, ([Income_Share_of_the_Richest_TenPercent_Pre-Tax]) AS Income_Share_RichestTenPercent,
([Income_Share_of_the_Richest_OnePercent_Pre-Tax]) AS Income_Share_RichestOnePercent,
([Income_Share_of_the_Richest_ZeroPointOnePercent_Pre-Tax]) AS Income_Share_RichestZeroPointOnePercent,
([Income_Share_of_the_Poorest_FiftyPercent_Pre-Tax]) AS Income_Share_PoorestFiftyPercent
FROM dbo.EconomicInequality$
WHERE Country = 'United States'
AND [Income_Share_of_the_Richest_TenPercent_Pre-Tax] != 'NULL'
AND [Income_Share_of_the_Richest_OnePercent_Pre-Tax] != 'NULL'
AND [Income_Share_of_the_Richest_ZeroPointOnePercent_Pre-Tax] != 'NULL'
AND [Income_Share_of_the_Poorest_FiftyPercent_Pre-Tax] != 'NULL'
GROUP BY Country, Year, [Income_Share_of_the_Richest_TenPercent_Pre-Tax], [Income_Share_of_the_Richest_OnePercent_Pre-Tax],
[Income_Share_of_the_Richest_ZeroPointOnePercent_Pre-Tax], [Income_Share_of_the_Poorest_FiftyPercent_Pre-Tax]
ORDER BY Year

-- Analyzing USA's Overall Economic Growth Throughout Time

SELECT Entity, Year, [GDP per capita, PPP (constant 2017 international $)] AS GDP_Per_Capita
FROM dbo.gdppercapita
WHERE Entity = 'United States'
ORDER BY Year

-- Analyzing the Years In Which USA had the Best GDP Per Capita Numbers

SELECT Entity, Year, [GDP per capita, PPP (constant 2017 international $)] AS GDP_Per_Capita
FROM dbo.gdppercapita
WHERE Entity = 'United States'
ORDER BY [GDP per capita, PPP (constant 2017 international $)] DESC


--- GLOBAL STATISTICS

-- Arranging Years By Average GDP Per Capita of the Whole World

SELECT Year, AVG([GDP per capita, PPP (constant 2017 international $)]) AS Average_GDP_Per_Capita
FROM dbo.gdppercapita
WHERE [GDP per capita, PPP (constant 2017 international $)] > 1
GROUP BY Year
ORDER BY AVG([GDP per capita, PPP (constant 2017 international $)]) DESC

-- Pulling Up the Countries with the Lowest GDPs Per Capita Recorded in 2021

SELECT Entity, Year, [GDP per capita, PPP (constant 2017 international $)] AS GDP_Per_Capita
FROM dbo.gdppercapita
WHERE Year = 2021
GROUP BY Entity, Year, [GDP per capita, PPP (constant 2017 international $)]
ORDER BY [GDP per capita, PPP (constant 2017 international $)]

-- Pulling Up the Countries with the Highest GDPs Per Capita Recorded in 2021

SELECT Entity, Year, [GDP per capita, PPP (constant 2017 international $)] AS GDP_Per_Capita
FROM dbo.gdppercapita
WHERE Year = 2021
GROUP BY Entity, Year, [GDP per capita, PPP (constant 2017 international $)]
ORDER BY [GDP per capita, PPP (constant 2017 international $)] DESC

-- Determining the Countries with the Lowest GDP Per Capita of All Time

SELECT Entity, MIN([GDP per capita, PPP (constant 2017 international $)]) AS GDP_Per_Capita
FROM dbo.gdppercapita
WHERE Entity != 'North America (WB)'
GROUP BY Entity
ORDER BY MIN([GDP per capita, PPP (constant 2017 international $)])

-- Determining the Countries with the Highest GDP Per Capita Of All Time

SELECT Entity, MAX([GDP per capita, PPP (constant 2017 international $)]) AS GDP_Per_Capita
FROM dbo.gdppercapita
WHERE Entity != 'North America (WB)'
GROUP BY Entity
ORDER BY MAX([GDP per capita, PPP (constant 2017 international $)]) DESC

-- Pulling Up Each Year's Lowest-Recorded GDP Per Capita

SELECT Year, MIN([GDP per capita, PPP (constant 2017 international $)]) AS Lowest_GDP_Per_Capita
FROM dbo.gdppercapita
WHERE [GDP per capita, PPP (constant 2017 international $)] > 1
GROUP BY Year
ORDER BY Year

-- Pulling Up Each Year's Highest-Recorded GDP Per Capita

SELECT Year, MAX([GDP per capita, PPP (constant 2017 international $)]) AS Highest_GDP_Per_Capita
FROM dbo.gdppercapita
WHERE [GDP per capita, PPP (constant 2017 international $)] > 1
GROUP BY Year
ORDER BY Year

-- TOTAL WEALTH Produced In The World Each Year

SELECT YEAR, SUM([GDP per capita, PPP (constant 2017 international $)]) AS Worldwide_Total_GDP_Per_Capita
FROM dbo.gdppercapita
GROUP BY Year
ORDER BY Year


-- JOINING THE 2 TABLES

SELECT *
FROM SelfProject_EconomicMeasures.dbo.EconomicInequality$ einq
JOIN SelfProject_EconomicMeasures.dbo.gdppercapita gdpc
ON einq.Country = gdpc.Entity
AND einq.Year = gdpc.Year

-- Comparing Each Country's GDP Per Capita to Income Shares of the Highest-Earners Per Year

SELECT einq.Country, einq.Year, gdpc.[GDP per capita, PPP (constant 2017 international $)] AS GDP_Per_Capita,
einq.[Income_Share_of_the_Richest_TenPercent_Pre-Tax] AS Income_Share_TopTenPercent, 
einq.[Income_Share_of_the_Richest_OnePercent_Pre-Tax] AS Income_Share_TopOnePercent,
einq.[Income_Share_of_the_Richest_ZeroPointOnePercent_Pre-Tax] AS Income_Share_TopZeroPointOnePercent
FROM SelfProject_EconomicMeasures.dbo.EconomicInequality$ einq
JOIN SelfProject_EconomicMeasures.dbo.gdppercapita gdpc
ON einq.Country = gdpc.Entity
AND einq.Year = gdpc.Year
GROUP BY einq.Country, einq.Year, gdpc.[GDP per capita, PPP (constant 2017 international $)],
einq.[Income_Share_of_the_Richest_TenPercent_Pre-Tax], 
einq.[Income_Share_of_the_Richest_OnePercent_Pre-Tax],
einq.[Income_Share_of_the_Richest_ZeroPointOnePercent_Pre-Tax]
ORDER BY Country, Year

-- Comparing Each Country's GDP Per Capita to Income Shares of the The Latter Half of the Population By Year

SELECT einq.Country, einq.Year, gdpc.[GDP per capita, PPP (constant 2017 international $)] AS GDP_Per_Capita,
einq.[Income_Share_of_the_Poorest_FiftyPercent_Pre-Tax] AS Income_Share_PoorestFiftyPercent
FROM SelfProject_EconomicMeasures.dbo.EconomicInequality$ einq
JOIN SelfProject_EconomicMeasures.dbo.gdppercapita gdpc
ON einq.Country = gdpc.Entity
AND einq.Year = gdpc.Year
GROUP BY einq.Country, einq.Year, gdpc.[GDP per capita, PPP (constant 2017 international $)],
einq.[Income_Share_of_the_Poorest_FiftyPercent_Pre-Tax]
ORDER BY Country, Year
