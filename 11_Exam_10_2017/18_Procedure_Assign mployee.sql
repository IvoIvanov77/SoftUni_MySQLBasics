DELIMITER $$
CREATE PROCEDURE usp_assign_employee_to_report
(employee_id INT, report_id INT) 
BEGIN 
START TRANSACTION; 
	IF(
		(
			SELECT e.department_id
			FROM employees AS e
			WHERE e.id = employee_id) != 
		(
			SELECT c.department_id
			FROM reports AS r
			INNER JOIN categories AS c ON c.id = r.category_id			
			WHERE r.id = report_id
		)
		) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Employee doesn\'t belong TO the appropriate department!';
			ROLLBACK; 
	ELSE
		UPDATE reports AS r SET r.employee_id = employee_id
		WHERE r.id = report_id; 
	END IF; 
END$$