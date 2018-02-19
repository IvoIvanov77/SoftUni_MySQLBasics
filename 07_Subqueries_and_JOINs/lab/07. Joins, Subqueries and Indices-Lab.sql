--Lab: Subqueries and JOINs

/*
01_Managers
Write a query to retrieve information about the managers – id, full_name, deparment_id and department_name. 
Select first 5 departments ordered by employee_id.  
*/

SELECT e.employee_id, CONCAT(e.first_name, ' ', e.last_name) AS full_name, d.department_id, d.name
FROM employees AS e
RIGHT JOIN departments AS d ON d.manager_id = e.employee_id
ORDER BY e.employee_id
LIMIT 5;

/*
02_Towns Addresses
Write a query to get information about addresses in the database, which are in San Francisco, Sofia or Carnation. 
Retrieve town_id, town_name, address_text. Order the result by town_id, then by address_id.
*/

SELECT a.town_id, t.name, a.address_text
FROM addresses AS a
INNER JOIN towns AS t ON a.town_id = t.town_id AND t.name 
IN('San Francisco', 'Sofia', 'Carnation')
ORDER BY a.town_id, a.address_id;

/*
03_Employees Without Managers
Write a get information about employee_id, first_name, last_name, department_id and salary about all employees who don’t have a manager. 
*/

SELECT e.employee_id, e.first_name, e.last_name, e.department_id, e.salary
FROM employees AS e
WHERE e.manager_id IS NULL;

/*
04_Higher Salary
Write a query to count the number of employees who receive salary higher than the average. 
*/

SELECT COUNT(e.employee_id)
FROM employees AS e
WHERE e.salary > (
SELECT AVG(salary)
FROM employees);


