DELIMITER $$
CREATE FUNCTION udf_get_reports_count(employee_id INT, status_id INT) 
RETURNS INT 
BEGIN 
	RETURN (select count(r.id) from reports as r
	where r.employee_id = employee_id and r.status_id = status_id);
END$$