--Lab: Data Aggregation

--Download and get familiar with the restaurant database. You will use it in the assignments bellow.

/*
01_Departments Info
Write a query to count the number of employees in each department by id. 
Order the information by deparment_id, then by employees count.
*/

SELECT e.`department_id`, count(e.id) AS `Number of employees`
FROM `employees` AS e
GROUP BY e.`department_id`
order by e.`department_id`, `Number of employees`;

/*
02_Average Salary
Write a query to calculate the average salary in each department. Order the information by department_id. 
Round the salary result to two digits after the decimal point. 
*/

SELECT e.`department_id`, ROUND(AVG(e.salary), 2) AS `Average Salary`
FROM `employees` AS e
GROUP BY e.`department_id`
ORDER BY e.`department_id`;

/*
03_Min Salary
Write a query to retrieve information about the departments grouped by department_id with minumum salary higher than 800. 
Round the salary result to two digits after the decimal point. Submit your queries with the MySQL prepare DB & run queries strategy.
*/

SELECT e.`department_id`, ROUND(MIN(e.salary), 2) AS `Min Salary`
FROM `employees` AS e
GROUP BY e.`department_id`
HAVING `Min Salary` > 800;

/*
04_Appetizers Count
Write a query to retrieve the count of all appetizers (category id = 2) with price higher than 8. 
*/

SELECT COUNT(id) AS `count`
FROM products
WHERE price > 8
GROUP BY `category_id`
HAVING `category_id` = 2;

/*
05_Menu Prices
Write a query to retrieve information about the prices of each category. The output should consist of:
•	Category_id
•	Average Price 
•	Cheapest Product
•	Most Expensive Product
See the examples for more information. Round the results to 2 digits after the decimal point. 
Example
category_id	Average Price	Cheapest Product	Most Expensive Product
1	           7.49	              6.79	                8.79
2	           10.93	          7.99	                14.89
3	           7.90	              6.90	                8.89
4	           12.79	          11.69	                13.69
5	           5.37	              4.90	                5.60
*/

SELECT `category_id`,
ROUND(AVG(price), 2) AS `Average Price`,
ROUND(MIN(price), 2) AS `Cheapest Product`,
ROUND(MAX(price), 2) AS `Most Expensive Product`
FROM products
GROUP BY `category_id`

