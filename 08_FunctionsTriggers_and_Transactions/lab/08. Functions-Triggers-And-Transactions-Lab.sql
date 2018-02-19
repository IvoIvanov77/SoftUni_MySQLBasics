--Lab: Functions, Triggers and Transactions
 
--You are provided with the “soft_uni” database. Use it in the following assignments.

/*
01_Count Employees by Town
Write a function ufn_count_employees_by_town(town_name) that accepts town_name as parameter 
and returns the count of employees who live in that town. 
*/

delimiter $$
CREATE FUNCTION ufn_count_employees_by_town(town_name VARCHAR(20)) 
RETURNS INT 
BEGIN 
	DECLARE e_count INT; SET e_count := (
	SELECT COUNT(t.name)
	FROM employees AS e
	JOIN addresses AS a ON a.address_id = e.address_id
	JOIN towns AS t ON t.town_id = a.town_id
	WHERE t.name = town_name); 
	RETURN e_count; 
END$$

/*
02_Employees Promotion
Write a stored procedure usp_raise_salaries(department_name) to raise the salary of all employees in given department as parameter by 5%. 
*/
DELIMITER $$
CREATE PROCEDURE usp_raise_salaries(department_name VARCHAR(50))
BEGIN
	UPDATE employees AS e
	JOIN departments AS d ON d.department_id = e.department_id SET e.salary = 1.05 * e.salary
WHERE d.name = department_name; 
END$$

/*
03_Employees Promotion By ID
Write a stored procedure usp_raise_salary_by_id(id) that raises a given employee’s salary (by id as parameter) by 5%. 
Consider that you cannot promote an employee that doesn’t exist – if that happens, no changes to the database should be made.
*/

DELIMITER $$
CREATE PROCEDURE usp_raise_salary_by_id(id INT)
BEGIN
	START TRANSACTION; 
	IF(
	SELECT COUNT(employee_id)
	FROM employees AS e
	WHERE e.employee_id LIKE id) <> 1 THEN ROLLBACK;
	ELSE
	UPDATE employees AS e SET e.salary = 1.05 * e.salary
	WHERE e.employee_id = id;
	END IF;
END$$

/*
04_Triggered
Create a table deleted_employees(employee_id PK, first_name,last_name,middle_name,job_title,deparment_id,salary) 
that will hold information about fired(deleted) employees from the employees table. 
Add a trigger to employees table that inserts the corresponding information in deleted_employees. 
*/

CREATE TABLE deleted_employees(
employee_id INT PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(20),
last_name VARCHAR(20),
middle_name VARCHAR(20),
job_title VARCHAR(50),
department_id INT,
salary DOUBLE
);

delimiter $$
CREATE TRIGGER tr_deleted_employees
AFTER DELETE
ON employees
FOR EACH ROW
BEGIN
	INSERT INTO deleted_employees (first_name,last_name,middle_name,job_title,department_id,salary)
	VALUES(OLD.first_name,OLD.last_name,OLD.middle_name,OLD.job_title,OLD.department_id,OLD.salary);
END $$;


