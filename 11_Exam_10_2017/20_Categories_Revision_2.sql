SELECT c.name AS category_name, COUNT(*) AS reports_number,
(
	CASE 
		WHEN (
			SELECT COUNT(*)
			FROM reports AS r1
			WHERE r1.category_id = r.category_id AND r1.status_id = 1) > (
			SELECT COUNT(*)
			FROM reports AS r2
			WHERE r2.category_id = r.category_id AND r2.status_id = 2) THEN 'waiting' 
		WHEN (
			SELECT COUNT(*)
			FROM reports AS r1
			WHERE r1.category_id = r.category_id AND r1.status_id = 1) = (
			SELECT COUNT(*)
			FROM reports AS r2
			WHERE r2.category_id = r.category_id AND r2.status_id = 2) THEN 'equal' 
		ELSE 'in progress' 
	END
) AS main_status
FROM reports AS r
INNER JOIN categories AS c ON c.id = r.category_id
WHERE r.status_id IN (1, 2)
GROUP BY r.category_id
ORDER BY c.name;

