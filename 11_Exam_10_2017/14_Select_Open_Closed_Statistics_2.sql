/*Select all employees who have at least one assigned closed (have a closed_date value) / open report through year 2016 and their number. 
Reports that have been opened before 2016 but were closed in 2016 are counted as closed only! Order the results by name alphabetically.*/
DELIMITER $$
CREATE FUNCTION ufn_get_count_open_date (id int)
	RETURNS VARCHAR(5)
	BEGIN		
		RETURN IFNULL((select count(*)  from reports as r1
		where YEAR(r1.open_date) = 2016
		group by r1.employee_id
		having r1.employee_id = id), 0);
	END$$
	
DELIMITER $$
CREATE FUNCTION ufn_get_count_close_date (id int)
	RETURNS VARCHAR(5)
	BEGIN		
		RETURN IFNULL((select count(*)  from reports as r1
		where YEAR(r1.close_date) = 2016
		group by r1.employee_id
		having r1.employee_id = id), 0);
	END$$	
	
SELECT CONCAT(e.first_name, ' ', e.last_name) AS name, CONCAT(ufn_get_count_close_date(e.id), '/', ufn_get_count_open_date(e.id))
FROM employees AS e
WHERE ufn_get_count_open_date(e.id) > 0 OR ufn_get_count_close_date(e.id) > 0
ORDER BY name