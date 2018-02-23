SELECT d.name, c.name, ROUND((COUNT(r.category_id) / (
	SELECT COUNT(r1.category_id)
	FROM reports AS r1
	INNER JOIN categories AS c1 ON c1.id = r1.category_id
	INNER JOIN departments AS d1 ON d1.id = c1.department_id
	WHERE d.id = d1.id
	GROUP BY d1.id
) * 100)) AS percentage
FROM reports AS r
INNER JOIN categories AS c ON c.id = r.category_id
INNER JOIN departments AS d ON d.id = c.department_id
GROUP BY c.id
ORDER BY d.name, c.name, percentage;