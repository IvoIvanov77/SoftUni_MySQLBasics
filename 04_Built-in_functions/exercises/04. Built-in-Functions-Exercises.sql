
--Part I – Queries for SoftUni Database

/*
01_Find Names of All Employees by First Name
Write a SQL query to find first and last names of all employees whose first name starts 
with “Sa” (case insensitively). Order the information by id. 
*/

SELECT first_name, last_name
FROM employees
WHERE first_name LIKE 'sa%';

/*
02_Find Names of All employees by Last Name 
Write a SQL query to find first and last names of all employees whose last name contains 
“ei” (case insensitively). Order the information by id. 
*/

SELECT first_name, last_name
FROM employees
WHERE last_name LIKE '%ei%';

/*
03_Find First Names of All Employees
Write a SQL query to find the first names of all employees in the departments with 
ID 3 or 10 and whose hire year is between 1995 and 2005 inclusive. 
Order the information by id. 
*/

SELECT first_name
FROM employees
WHERE department_id IN(3, 10) 
AND YEAR(hire_date) BETWEEN 1995 AND 2005;

/*
04_Find All Employees Except Engineers
Write a SQL query to find the first and last names of all employees 
whose job titles does not contain “engineer”. Order by id. 
*/

SELECT first_name, last_name
FROM employees
WHERE job_title NOT LIKE('%engineer%');

/*
05_Find Towns with Name Length
Write a SQL query to find town names that are 5 or 6 symbols long 
and order them alphabetically by town name. 
*/

SELECT name
FROM towns
WHERE CHAR_LENGTH(name) BETWEEN 5 AND 6
ORDER BY name;

/*
-6_Find Towns Starting With
Write a SQL query to find all towns that start with letters M, K, B or E (case insensitively). 
Order them alphabetically by town name. 
*/

SELECT *
FROM towns
WHERE LEFT(name, 1) IN('M', 'K', 'B', 'E')
ORDER BY name;

/*
07_Find Towns Not Starting With
Write a SQL query to find all towns that does not start with letters R, B or D (case insensitively). 
Order them alphabetically by name. 
*/

SELECT *
FROM towns
WHERE LEFT(name, 1) NOT IN('R', 'B', 'D')
ORDER BY name;

/*
08_Create View Employees Hired After 2000 Year
Write a SQL query to create view v_employees_hired_after_2000 
with first and last name to all employees hired after 2000 year. 
*/

CREATE VIEW v_employees_hired_after_2000 AS
SELECT first_name, last_name
FROM employees
WHERE YEAR(hire_date) > 2000;
SELECT *
FROM v_employees_hired_after_2000;

/*
09_Length of Last Name
Write a SQL query to find the names of all employees whose last name is exactly 5 characters long.
*/

SELECT first_name, last_name
FROM employees
WHERE CHAR_LENGTH(last_name) = 5;

--Part II – Queries for Geography Database 

/*
10_Countries Holding ‘A’ 3 or More Times
Find all countries that holds the letter 'A' in their name at least 3 times (case insensitively), 
sorted by ISO code. Display the country name and ISO code. 
*/

SELECT country_name, iso_code
FROM countries
WHERE CHAR_LENGTH(country_name) - CHAR_LENGTH(
REPLACE(LOWER(country_name), 'a', '')) >= 3
ORDER BY iso_code;

/*
11_Mix of Peak and River Names
Combine all peak names with all river names, so that the last letter of each peak name 
is the same like the first letter of its corresponding river name. 
Display the peak names, river names, and the obtained mix. Sort the results by the obtained mix. 
*/

SELECT p.peak_name,
r.river_name, LOWER(CONCAT(
LEFT(p.peak_name, CHAR_LENGTH(p.peak_name) - 1), '', r.river_name)) AS mix
FROM rivers AS r, peaks AS p
WHERE(
RIGHT(p.peak_name,1) =
LEFT(r.river_name,1))
ORDER BY mix;

--Part III – Queries for Diablo Database

/*
12_Games from 2011 and 2012 year
Find the top 50 games ordered by start date, then by name of the game. 
Display only games from 2011 and 2012 year. 
Display start date in the format “YYYY-MM-DD”. 
*/

SELECT `name`, DATE_FORMAT(`start`, '%Y-%m-%d')
FROM games
WHERE YEAR(`start`) IN(2011, 2012)
ORDER BY `start`, `name`
LIMIT 50;

/*
13_User Email Providers
Find all users along with information about their email providers. 
Display the user_name and email provider. 
Sort the results by email provider alphabetically, then by username. 
*/

SELECT user_name, SUBSTRING(email, LOCATE('@', email) + 1) 
AS `Email Provider`
FROM users
ORDER BY `Email Provider`, user_name;

/*
14_Get Users with IP Address Like Pattern
Find all user_name and  ip_address for each user sorted by user_name alphabetically. 
Display only rows that ip_address matches the pattern: “___.1%.%.___”. 
*/

SELECT u.user_name, u.ip_address
FROM users AS u
WHERE(u.ip_address LIKE '___.1%.%.___')
ORDER BY u.user_name;

/*
15_Show All Games with Duration and Part of the Day
Find all games with part of the day and duration. Parts of the day should be 
Morning (start time is >= 0 and < 12), Afternoon (start time is >= 12 and < 18), 
Evening (start time is >= 18 and < 24). Duration should be Extra Short (smaller or equal to 3), 
Short (between 3 and 6 including), Long (between 6 and 10 including) 
and Extra Long in any other cases or without duration. 
*/

SELECT name, CASE
WHEN HOUR(`start`) >= 0 AND HOUR(`start`) < 12 THEN 'Morning'
WHEN HOUR(`start`) >= 12 AND HOUR(`start`) < 18 THEN 'Afternoon'
WHEN HOUR(`start`) >= 18 AND HOUR(`start`) < 24 THEN 'Evening' END AS 'Part of the Day',
CASE WHEN duration <= 3 THEN 'Extra Short'
WHEN duration > 3 AND duration <= 6 THEN 'Short'
WHEN duration > 6 AND duration <= 10 THEN 'Long'
WHEN duration > 10 OR duration IS NULL THEN 'Extra Long' END AS 'Duration'
FROM games;

--Part IV – Date Functions Queries

/*
16_Orders Table
You are given a table orders(id, product_name, order_date) filled with data. 
Consider that the payment for that order must be accomplished within 3 days after the order date. 
Also the delivery date is up to 1 month. Write a query to show each product’s name, order date, pay and deliver due dates. 
*/

SELECT product_name,
order_date, DATE_ADD(order_date, INTERVAL 3 DAY) AS 'pay_due', 
DATE_ADD(order_date, INTERVAL 1 MONTH) AS 'deliver_due'
FROM orders;

