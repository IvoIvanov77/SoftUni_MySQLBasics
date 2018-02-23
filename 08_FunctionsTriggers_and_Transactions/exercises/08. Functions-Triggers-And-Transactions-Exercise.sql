
/*
Part I – Queries for SoftUni Database

01_Employees with Salary Above 35000
Create stored procedure usp_get_employees_salary_above_35000 that returns all employees’ 
first and last names for whose salary is above 35000. 
The result should be sorted by first_name then by last_name alphabetically, and id ascending. 
*/


DELIMITER $$
CREATE PROCEDURE usp_get_employees_salary_above_35000() 
BEGIN
	SELECT first_name, last_name
	FROM employees AS e
	WHERE e.salary > 35000
	ORDER BY e.first_name, e.last_name, e.employee_id;
END$$ 

/*
02_Employees with Salary Above Number
Create stored procedure usp_get_employees_salary_above that accept a number as parameter 
and return all employees’ first and last names whose salary 
is above or equal to the given number. The result should be sorted by 
first_name then by last_name alphabetically and id ascending. 
*/

DELIMITER $$
CREATE PROCEDURE usp_get_employees_salary_above (number DECIMAL(19,4))
BEGIN
	SELECT first_name, last_name
	FROM employees AS e
	WHERE e.salary >= number
	ORDER BY e.first_name, e.last_name, e.employee_id;
END$$

/*
03_Town Names Starting With
Write a stored procedure usp_get_towns_starting_with that accept string as 
parameter and returns all town names starting with that string. 
The result should be sorted by town_name alphabetically. 
*/

DELIMITER $$
CREATE PROCEDURE usp_get_towns_starting_with(word varchar(50))
BEGIN
	SELECT name
	FROM towns AS t
	WHERE t.name like CONCAT(word, '%')
	ORDER BY t.name;
END$$ 

/*

04_Employees from Town
Write a stored procedure usp_get_employees_from_town that accepts town_name as parameter 
and return the employees’ first and last name that live in the given town. 
The result should be sorted by first_name then by last_name alphabetically and id ascending.

*/

DELIMITER $$
CREATE PROCEDURE usp_get_employees_from_town(town_name VARCHAR(50))
BEGIN
	SELECT first_name, last_name
	FROM employees AS e
	join addresses as a on a.address_id = e.address_id
	join towns as t on t.town_id = a.town_id
	WHERE t.name = town_name
	ORDER BY e.first_name, e.last_name, e.employee_id;
END$$


/*
05_Salary Level Function
Write a function ufn_get_salary_level that receives salary of an employee and returns the level of the salary.
	If salary is < 30000 return “Low”
	If salary is between 30000 and 50000 (inclusive) return “Average”
	If salary is > 50000 return “High”
*/

DELIMITER $$
CREATE FUNCTION ufn_get_salary_level (salary DECIMAL(19,4))
	RETURNS VARCHAR(50)
	BEGIN
		DECLARE level_salary VARCHAR(20);
		IF(salary < 30000) THEN SET level_salary := 'Low';
		ELSEIF(salary >= 30000 AND salary <= 50000) THEN SET level_salary := 'Average';
		ELSE SET level_salary := 'High';
		END IF;
		RETURN level_salary;
	END$$

/*
06_Employees by Salary Level
Write a stored procedure usp_get_employees_by_salary_level that receive as parameter level of salary 
(low, average or high) and print the names of all employees that have given level of salary. 
The result should be sorted by first_name then by last_name both in descending order.
*/

DELIMITER $$
CREATE FUNCTION ufn_get_salary_level (salary DECIMAL(19,4))
	RETURNS VARCHAR(50)
	BEGIN
		DECLARE level_salary VARCHAR(20);
		IF(salary < 30000) THEN SET level_salary := 'Low';
		ELSEIF(salary >= 30000 AND salary <= 50000) THEN SET level_salary := 'Average';
		ELSE SET level_salary := 'High';
		END IF;
		RETURN level_salary;
	END$$

DELIMITER $$
CREATE PROCEDURE usp_get_employees_by_salary_level(salary_level VARCHAR(20))
BEGIN
SELECT first_name, last_name
FROM employees AS e
WHERE ufn_get_salary_level(e.salary) = salary_level
ORDER BY e.first_name desc, e.last_name desc;
END$$

/*
07_Define Function
Define a function ufn_is_word_comprised(set_of_letters varchar(50), word varchar(50))  
that returns true or false depending on that if the word is a comprised of the given set of letters. 
*/

DELIMITER $$
CREATE FUNCTION ufn_is_word_comprised(set_of_letters VARCHAR(50), word VARCHAR(50))
	RETURNS BOOL
	BEGIN
		DECLARE lenght INT DEFAULT CHAR_LENGTH(word);
		DECLARE char_index INT DEFAULT 1;
		WHILE char_index <= lenght
		DO
		IF LOCATE(SUBSTRING(word, char_index, 1), set_of_letters) < 1
		THEN RETURN FALSE;
		END IF;
		SET char_index = char_index + 1;
		END WHILE;
		RETURN TRUE;
	END$$
	
--100/100 judge	
CREATE FUNCTION ufn_is_word_comprised(set_of_letters varchar(50), word varchar(50))
RETURNS BIT
RETURN word REGEXP (concat('^[', set_of_letters, ']+$'));

/*
08*_Delete Employees and Departments
Write a SQL query to delete all employees from the Production and
Production Control departments. Also delete these departments from
the departments table.
*/

ALTER TABLE departments DROP FOREIGN KEY `fk_departments_employees`;
ALTER TABLE departments DROP INDEX `fk_departments_employees` ;
ALTER TABLE employees_projects DROP FOREIGN KEY `fk_employees_projects_employees`;
ALTER TABLE employees DROP FOREIGN KEY `fk_employees_employees`;

DELETE FROM employees
WHERE
    department_id IN (SELECT 
        d.department_id
    FROM
        departments AS d
    WHERE
        d.name IN ('Production' , 'Production Control'));
        
DELETE FROM departments 
WHERE
    name IN ('Production' , 'Production Control');

/*
PART II – Queries for Bank Database

08_Find Full Name
You are given a database schema with tables:
	account_holders(id (PK), first_name, last_name, ssn) 
and 
	accounts(id (PK), account_holder_id (FK), balance).
Write a stored procedure usp_get_holders_full_name that selects the full names of all people. 
The result should be sorted by full_name alphabetically and id ascending. 
*/

DELIMITER $$
CREATE PROCEDURE usp_get_holders_full_name()
BEGIN
	SELECT CONCAT(first_name, ' ', last_name) AS full_name
	FROM account_holders
	ORDER BY full_name;
END $$

/*
09_People with Balance Higher Than
Your task is to create a stored procedure usp_get_holders_with_balance_higher_than that accepts a number as a parameter 
and returns all people who have more money in total of all their accounts than the supplied number. 
The result should be sorted by first_name then by last_name alphabetically and account id ascending. 
*/

DELIMITER $$
CREATE PROCEDURE usp_get_holders_with_balance_higher_than(number DECIMAL(19, 4))
BEGIN
	SELECT ah.first_name, ah.last_name
	FROM account_holders AS ah
	JOIN(
	SELECT account_holder_id, SUM(balance) AS tottal
	FROM accounts
	GROUP BY account_holder_id) AS a ON a.account_holder_id = ah.id
	WHERE tottal > number
	ORDER BY ah.first_name, ah.last_name, ah.id;
END $$

--100/100 judge
DELIMITER $$
CREATE PROCEDURE usp_get_holders_with_balance_higher_than(number DECIMAL(19, 4))
BEGIN
	SELECT ah.first_name, ah.last_name
	FROM account_holders AS ah
	JOIN(
	SELECT id, account_holder_id, SUM(balance) AS tottal
	FROM accounts
	GROUP BY account_holder_id) AS a ON a.account_holder_id = ah.id
	WHERE tottal > number
	ORDER BY a.id;
END $$


/*
10_Future Value Function
Your task is to create a function ufn_calculate_future_value that accepts as parameters – sum, yearly interest rate and number of years. 
It should calculate and return the future value of the initial sum. Using the following formula:
FV=I×(〖(1+R)〗^T)
	I – Initial sum
	R – Yearly interest rate
	T – Number of years
*/

DELIMITER $$
CREATE FUNCTION ufn_calculate_future_value(i DECIMAL(19,2), r DECIMAL(19,2), t INT)
	RETURNS FLOAT(10, 2)
	BEGIN
		RETURN (i * (POW((1 + r), t)));
	END$$


/*
11_Calculating Interest
Your task is to create a stored procedure usp_calculate_future_value_for_account that uses the function from the previous problem 
to give an interest to a person's account for 5 years, along with information about his/her account id, first name, 
last name and current balance as it is shown in the example below. It should take the account_id and the interest_rate as parameters. 
Interest rate should have precision up to 0.0001, same as the calculated balance after 5 years. Be extremely careful to achieve the desired precision!
*/

DELIMITER $$
CREATE PROCEDURE usp_calculate_future_value_for_account (account_id INT, interest_rate DECIMAL(19,4))
BEGIN DECLARE future_value DECIMAL(19,4);
	DECLARE balance DECIMAL(19, 4);
	SET balance := (
	SELECT a.balance
	FROM accounts AS a
	WHERE a.id = account_id);
	SET future_value := balance * (POW((1 + interest_rate), 5));
	SELECT a.id AS account_id, ah.first_name, ah.last_name, a.balance, future_value
	FROM accounts AS a
	INNER JOIN account_holders AS ah ON a.account_holder_id = ah.id AND a.id = account_id;
END$$

--My solution:
DELIMITER $$
CREATE FUNCTION ufn_calculate_future_value(i DECIMAL(19,4), r DECIMAL(19,4), t INT)
	RETURNS DECIMAL(19, 4)
	BEGIN
		RETURN (i * (POW((1 + r), t)));
	END $$

DELIMITER $$
CREATE PROCEDURE usp_calculate_future_value_for_account(account_id INT, interest_rate DECIMAL(10, 4))
BEGIN
	SELECT a.id, ah.first_name, ah.last_name, a.balance AS current_balance,
	ufn_calculate_future_value(a.balance, interest_rate, 5)
	FROM accounts AS a
	JOIN account_holders AS ah ON ah.id = a.account_holder_id
	WHERE a.id = account_id;
END $$

/*
12_Deposit Money
Add stored procedure usp_deposit_money(account_id, money_amount) that operate in transactions. 
Make sure to guarantee valid positive money_amount with precision up to fourth sign after decimal point. 
The procedure should produce exact results working with the specified precision.
*/

CREATE PROCEDURE usp_deposit_money(account_id INT, money_amount DECIMAL(19,4))
BEGIN
	START TRANSACTION;
	IF(money_amount <= 0)
	THEN	ROLLBACK;
	ELSE
	UPDATE  accounts
	SET balance = balance + money_amount
	WHERE id = account_id;
	COMMIT;
	END IF;
END 

/*
13_Withdraw Money
Add stored procedures usp_withdraw_money(account_id, money_amount) that operate in transactions. 
Make sure to guarantee withdraw is done only when balance is enough and money_amount is valid positive number. 
Work with precision up to fourth sign after decimal point. The procedure should produce exact results working with the specified precision.
*/

DELIMITER $$
CREATE PROCEDURE usp_withdraw_money(account_id INT, money_amount DECIMAL(19,4))
BEGIN
	DECLARE acc_balance DECIMAL(19,4);
	SET acc_balance := (
	SELECT balance
	FROM accounts
	WHERE id = account_id);
	START TRANSACTION;
	IF(money_amount <= 0 OR acc_balance < money_amount) THEN ROLLBACK;
	ELSE
	UPDATE accounts SET balance = balance - money_amount
	WHERE id = account_id;
	COMMIT;
	END IF;
END $$

/*
14_Money Transfer
Write stored procedure usp_transfer_money(from_account_id, to_account_id, amount) that transfers money from one account to another. 
Consider cases when one of the account_ids is not valid, the amount of money is negative number, outgoing balance is enough or transferring 
from/to one and the same account. Make sure that the whole procedure passes without errors and if error occurs make no change in the database. 
Make sure to guarantee exact results working with precision up to fourth sign after decimal point.
*/

DELIMITER $$
CREATE PROCEDURE usp_transfer_money(from_account_id INT, to_account_id INT, money_amount DECIMAL(19,4))
BEGIN
	DECLARE from_account_balance DECIMAL(19,4);
	SET from_account_balance := (
	SELECT balance
	FROM accounts
	WHERE id = from_account_id);
	START TRANSACTION;
	IF((SELECT count(id) FROM accounts
	WHERE id IN(from_account_id, to_account_id))<>2) THEN ROLLBACK;
	ELSEIF(money_amount <= 0 OR from_account_balance < money_amount) THEN ROLLBACK;
	ELSE
	UPDATE accounts SET balance = balance - money_amount
	WHERE id = from_account_id;
	UPDATE accounts SET balance = balance + money_amount
	WHERE id = to_account_id;
	COMMIT;
	END IF;
END $$

/*
15_Log Accounts Trigger
Create another table – logs(log_id, account_id, old_sum, new_sum). Add a trigger to the accounts table that 
enters a new entry into the logs table every time the sum on an account changes.
*/

CREATE TABLE `logs`
(
	`log_id` INT AUTO_INCREMENT PRIMARY KEY,
	`account_id` INT,
	`old_sum` DECIMAL(19,4),
	`new_sum` DECIMAL(19,4)
);

DELIMITER $$
CREATE TRIGGER tr_change_sum
AFTER UPDATE
ON `accounts`
FOR EACH ROW
BEGIN
	INSERT INTO `logs`(`account_id`, `old_sum`, `new_sum`)
	VALUES (old.id, old.balance, new.balance);
END$$

/*
16_Emails Trigger
Create another table – notification_emails(id, recipient, subject, body). 
Add a trigger to logs table to create new email whenever new record is inserted in logs table. 
The following data is required to be filled for each email:
	recipient – account_id
	subject – “Balance change for account: {account_id}”
	body - “On {date (current date)} your balance was changed from {old} to {new}.”
*/

CREATE TABLE `notification_emails`
(
	`id` INT AUTO_INCREMENT PRIMARY KEY,
	`recipient` INT,
	`subject` VARCHAR(100),
	`body` TEXT
);

DELIMITER $$
CREATE TRIGGER tr_create_email
AFTER INSERT
ON `logs`
FOR EACH ROW
BEGIN
	INSERT INTO `notification_emails`(`recipient`, `subject`, `body`)
	VALUES (new.account_id, CONCAT('Balance change for account: ', new.account_id),
	CONCAT('On ', DATE_FORMAT(NOW(), '%b %d %Y %r'), ' your balance was changed from ',
	new.old_sum, ' to ', new.new_sum,'.'));
END$$

--Judge:
CREATE TABLE `logs`
(
	`log_id` INT AUTO_INCREMENT PRIMARY KEY,
	`account_id` INT,
	`old_sum` DECIMAL(19,4),
	`new_sum` DECIMAL(19,4)
);

CREATE TABLE `notification_emails`
(
	`id` INT AUTO_INCREMENT PRIMARY KEY,
	`recipient` INT,
	`subject` VARCHAR(100),
	`body` TEXT
);

CREATE TRIGGER tr_change_sum
AFTER UPDATE
ON `accounts`
FOR EACH ROW
BEGIN
	INSERT INTO `logs`(`account_id`, `old_sum`, `new_sum`)
	VALUES (old.id, old.balance, new.balance);
END;

CREATE TRIGGER tr_create_email
AFTER INSERT
ON `logs`
FOR EACH ROW
BEGIN
	INSERT INTO `notification_emails`(`recipient`, `subject`, `body`)
	VALUES (new.account_id, CONCAT('Balance change for account: ', new.account_id),
	CONCAT('On ', DATE_FORMAT(NOW(), '%b %d %Y %r'), ' your balance was changed from ',
	new.old_sum, ' to ', new.new_sum,'.'));
END;


