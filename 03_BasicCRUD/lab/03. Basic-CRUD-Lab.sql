/*
Download and get familiar with the hospital database schemas and tables. 
You will use it in the following exercises to write queries.
*/
/*
01_Select Employee Information
Write a query to select all employees and retrieve information about their id, first_name, 
last_name and job_title ordered by id.
*/

SELECT id, first_name, last_name, job_title 
FROM employees ORDER BY id;

/*
02_Select Employees with Filter
Write a query to select all employees (id, first_name, last_name, job_title, salary) whose salaries 
are higher than 1000.00, ordered by id. Concatenate fields first_name and last_name into ‘full_name’.
*/

SELECT id, CONCAT(first_name, ' ', last_name) AS full_name, job_title, salary 
FROM employees 
WHERE salary > 1000 ORDER BY id;

/*
03_Update Employees Salary
Update all employees salaries whose job_title is “Therapist” by 10%. 
Retrieve information about all salaries ordered ascending.
*/

UPDATE employees 
SET salary = 1.1 * salary 
WHERE job_title ='Therapist';

SELECT salary 
FROM employees 
ORDER BY salary ASC;

/*
04_Top Paid Employee
Write a query to create a view that selects all information about the top paid employee 
from the “employees” table in the hospital database.
*/

CREATE VIEW top_paid_employee 
AS SELECT * FROM employees 
ORDER BY salary DESC LIMIT 1;

SELECT * FROM top_paid_employee;

/*
05_Select Employees by Multiple Filters
Write a query to retrieve information about employees, who are in department 4 and have 
salary higher or equal to 1600. Order the information by id.
*/

SELECT * FROM employees 
WHERE department_id = 4 AND salary >= 1600 
ORDER BY id;

/*
06_Delete from Table
Write a query to delete all employees from the “employees” table who are in department 2 or 1. 
Order the information by id.
*/

DELETE FROM employees 
WHERE department_id IN(2,1);

SELECT * FROM employees ORDER BY id;







