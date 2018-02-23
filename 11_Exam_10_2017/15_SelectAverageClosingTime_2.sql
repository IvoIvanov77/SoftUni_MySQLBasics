/*Select all departments that have been reported in and the average time(in days) for closing a report for each department. 
If there is no information (e.g. none closed reports) about any department fill in the Average Duration column “no info”. 
Round the average duration to the nearest smaller integer value.
Order them by department name.*/

DELIMITER $$
CREATE FUNCTION ufn_get_average_days (id INT) 
RETURNS DOUBLE
BEGIN 
	RETURN(
		SELECT AVG(TO_DAYS(r.close_date) - TO_DAYS(r.open_date))
		FROM reports AS r
		INNER JOIN categories AS c ON c.id = r.category_id
		INNER JOIN departments AS d ON d.id = c.department_id
		WHERE d.id = id
		GROUP BY d.id
		); 
END$$

SELECT DISTINCT d.name, IFNULL(FLOOR(ufn_get_average_days (d.id)), 'no info') AS average_duration
FROM reports AS r
INNER JOIN categories AS c ON c.id = r.category_id
INNER JOIN departments AS d ON d.id = c.department_id
ORDER BY d.name;

