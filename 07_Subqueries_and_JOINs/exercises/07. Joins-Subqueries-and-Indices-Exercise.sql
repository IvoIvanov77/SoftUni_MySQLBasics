--Exercises: Subqueries and JOINs

--For problems from 1 to 11 (inclusively) use "soft_uni" database and for the other – "geography".

/*
01_Employee Address
Write a query that selects:
•	employee_id
•	job_title
•	address_id
•	address_text
Return the first 5 rows sorted by address_id in ascending order.
*/

SELECT e.employee_id, e.job_title, e.address_id, a.address_text
FROM employees AS e
INNER JOIN addresses AS a ON a.address_id = e.address_id
ORDER BY e.address_id
LIMIT 5;

/*
02_Addresses with Towns
Write a query that selects:
•	first_name
•	last_name
•	town
•	address_text
Sorted by first_name in ascending order then by last_name. Select first 5 employees.
*/

SELECT e.first_name, e.last_name, t.name, a.address_text
FROM employees AS e
INNER JOIN addresses AS a ON a.address_id = e.address_id
INNER JOIN towns AS t ON t.town_id = a.town_id
ORDER BY e.first_name, e.last_name
LIMIT 5;

/*
03_Sales Employee
Write a query that selects:
•	employee_id
•	first_name
•	last_name
•	department_name
Sorted by employee_id in descending order. Select only employees from “Sales” department.
*/

SELECT e.employee_id, e.first_name, e.last_name, d.name
FROM employees AS e
INNER JOIN departments AS d
ON d.department_id = e.department_id AND d.name = 'Sales'
ORDER BY e.employee_id DESC;

/*
04_Employee Departments
Write a query that selects:
•	employee_id
•	first_name
•	salary
•	department_name
Filter only employees with salary higher than 15000. Return the first 5 rows sorted by department_id in descending order.
*/

SELECT e.employee_id, e.first_name, e.salary, d.name
FROM employees AS e
INNER JOIN departments AS d
ON d.department_id = e.department_id AND e.salary > 15000
ORDER BY e.department_id DESC
limit 5;

/*
05_Employees Without Project
Write a query that selects:
•	employee_id
•	first_name
Filter only employees without a project. Return the first 3 rows sorted by employee_id in descending order.
*/

SELECT e.employee_id, e.first_name
FROM employees AS e
LEFT JOIN employees_projects AS ep ON e.employee_id = ep.employee_id
WHERE ep.employee_id IS NULL
ORDER BY e.employee_id DESC
LIMIT 3;

/*
06_Employees Hired After
Write a query that selects:
•	first_name
•	last_name
•	hire_date
•	dept_name
Filter only employees with hired after 1/1/1999 and are from either "Sales" or "Finance" departments. 
Sorted by hire_date (ascending).
*/

SELECT e.first_name, e.last_name, e.hire_date, d.name
FROM employees AS e
INNER JOIN departments AS d ON d.department_id = e.department_id
AND d.name IN('Sales', 'Finance')
WHERE (DATE(e.hire_date) > '1999-01-01')
ORDER BY e.hire_date;

/*
07_Employees with Project
Write a query that selects:
•	employee_id
•	first_name
•	project_name
Filter only employees with a project which has started after 13.08.2002 and it is still ongoing (no end date). 
Return the first 5 rows sorted by first_name then by project_name both  in ascending order.
*/

SELECT e.employee_id, e.first_name, p.name
FROM employees AS e
INNER JOIN employees_projects AS ep ON ep.employee_id = e.employee_id
INNER JOIN projects AS p ON p.project_id = ep.project_id
WHERE (DATE(p.start_date) > '2002-08-13' AND DATE(p.end_date) IS NULL)
ORDER BY e.first_name, p.name
LIMIT 5;

/*
08_Employee 24
Write a query that selects:
•	employee_id
•	first_name
•	project_name
Filter all the projects of employees with id 24. If the project has started after 2005 inclusively the return value should be NULL. 
Sort result by project_name alphabetically.
*/

SELECT e.employee_id, e.first_name, p.name AS project_name
FROM employees AS e
INNER JOIN employees_projects AS ep ON ep.employee_id = e.employee_id
LEFT JOIN projects AS p ON p.project_id = ep.project_id
AND YEAR(p.start_date) < 2005
WHERE e.employee_id = 24
ORDER BY p.name;

/*
09_Employee Manager
Write a query that selects:
•	employee_id
•	first_name
•	manager_id
•	manager_name
Filter all employees with a manager who has id equals to 3 or 7. Return the all rows sorted by employee first_name in ascending order.
*/

SELECT e1.employee_id, e1.first_name, e1.manager_id,
e2.first_name AS manager_name
FROM employees AS e1
INNER JOIN employees AS e2 ON e2.employee_id = e1.manager_id
WHERE e1.manager_id IN(3, 7)
ORDER BY e1.first_name;

/*
10_Employee Summary
Write a query that selects:
•	employee_id
•	employee_name
•	manager_name
•	department_name
Show first 5 employees (only for employees who has a manager) with their managers and the departments which they are in 
(show the departments of the employees). Order by employee_id.
*/

SELECT e1.employee_id, CONCAT(e1.first_name, ' ', e1.last_name) AS employee_name,
CONCAT(e2.first_name, ' ', e2.last_name) AS manager_name,
d.name AS department_name
FROM employees AS e1
INNER JOIN employees AS e2 ON e2.employee_id = e1.manager_id
INNER JOIN departments AS d ON e1.department_id = d.department_id
ORDER BY e1.employee_id
LIMIT 5;

/*
11_Min Average Salary
Write a query that return the value of the lowest average salary of all departments.
*/

SELECT MIN(average_salary)
FROM (
SELECT AVG(e.salary) AS average_salary
FROM employees AS e
GROUP BY e.department_id) AS min_average_salary;

/*
12_Highest Peaks in Bulgaria
Write a query that selects:
•	country_code	
•	mountain_range
•	peak_name
•	elevation
Filter all peaks in Bulgaria with elevation over 2835. Return the all rows sorted by elevation in descending order.
*/

SELECT mc.country_code, m.mountain_range, p.peak_name, p.elevation
FROM peaks AS p
INNER JOIN mountains AS m ON m.id = p.mountain_id
INNER JOIN mountains_countries AS mc ON mc.mountain_id = m.id
WHERE mc.country_code = 'BG' AND p.elevation > 2835
ORDER BY p.elevation DESC;

/*
13_Count Mountain Ranges
Write a query that selects:
•	country_code
•	mountain_range
Filter the count of the mountain ranges in the United States, Russia and Bulgaria. 
Sort result by mountain_range count  in decreasing order.
*/

SELECT mc.country_code, COUNT(mc.mountain_id) AS mountain_range
FROM mountains_countries AS mc
GROUP BY mc.country_code
HAVING mc.country_code IN('BG', 'RU', 'US')
ORDER BY mountain_range DESC;

/*
14_Countries with Rivers
Write a query that selects:
•	country_name
•	river_name
Find the first 5 countries with or without rivers in Africa. Sort them by country_name in ascending order.
*/

SELECT c.country_name, r.river_name
FROM countries AS c
LEFT JOIN countries_rivers AS cr ON cr.country_code = c.country_code
LEFT JOIN rivers AS r ON r.id = cr.river_id
WHERE c.continent_code = 'AF'
ORDER BY c.country_name
LIMIT 5;

/*
15_*Continents and Currencies
Write a query that selects:
•	continent_code
•	currency_code
•	currency_usage
Find all continents and their most used currency. Filter any currency that is used in only one country. 
Sort your results by continent_code and currency_code.
*/

SELECT c.continent_code, c.currency_code, COUNT(c.currency_code) AS curr_usage
FROM countries AS c
GROUP BY c.continent_code,c.currency_code
HAVING curr_usage > 1 AND curr_usage = (
			SELECT COUNT(c1.currency_code) AS c_count
			FROM countries AS c1
			WHERE c1.continent_code = c.continent_code
			GROUP BY c1.currency_code
			ORDER BY c_count DESC
			LIMIT 1)
ORDER BY c.continent_code, c.currency_code;

/*
16.	Countries without any Mountains
Find all the count of all countries which don’t have a mountain.
*/

SELECT COUNT(c.country_code) AS country_count
FROM countries AS c
LEFT JOIN mountains_countries AS mc ON mc.country_code = c.country_code
WHERE mc.mountain_id IS NULL;

/*
17.	Highest Peak and Longest River by Country
For each country, find the elevation of the highest peak and the length of the longest river, 
sorted by the highest peak_elevation (from highest to lowest), then by the longest river_length (from longest to smallest), 
then by country_name (alphabetically). Display NULL when no data is available in some of the columns. Limit only the first 5 rows.
*/

SELECT c.`country_name`,
MAX(p.`elevation`) AS `highest_peak_elevation`,
MAX(r.`length`) AS `longest_river_length`
FROM `countries` AS c
LEFT OUTER JOIN `mountains_countries` AS mc
ON c.country_code = mc.country_code
LEFT OUTER JOIN `mountains` AS m
ON mc.mountain_id = m.id
LEFT OUTER JOIN `peaks` AS p
ON p.mountain_id = m.id
LEFT OUTER JOIN `countries_rivers` AS cr
ON c.country_code = cr.country_code
LEFT OUTER JOIN `rivers` AS r
ON r.id = cr.river_id
GROUP BY c.country_name
ORDER BY `highest_peak_elevation` DESC, `longest_river_length` DESC,
c.country_name ASC
LIMIT 5;
-------------------------------------------------------------------------
SELECT c.country_name, (
	SELECT MAX(p.elevation)
	FROM peaks AS p
	INNER JOIN mountains_countries AS mc ON mc.mountain_id = p.mountain_id
	WHERE mc.country_code = c.country_code) AS highest_peak_elevation,
	(
	SELECT MAX(r.length)
	FROM rivers AS r
	INNER JOIN countries_rivers AS cr ON cr.river_id = r.id
	WHERE cr.country_code = c.country_code) AS longest_river_length
FROM countries AS c
ORDER BY highest_peak_elevation DESC, longest_river_length DESC
LIMIT 5;
---------------------------------------------------------------------------
ELECT c.country_name, p.elevation,r.length
FROM countries AS `c`
JOIN countries_rivers AS `cr` ON cr.country_code = c.country_code
JOIN mountains_countries AS `mc` ON mc.country_code = c.country_code
JOIN rivers AS `r` ON r.id = cr.river_id
JOIN peaks AS `p` ON p.mountain_id = mc.mountain_id
GROUP BY c.country_name
ORDER BY p.elevation DESC, r.length DESC, c.country_name ASC
LIMIT 5;

