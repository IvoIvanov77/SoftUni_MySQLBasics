SELECT d.name, IFNULL(FLOOR(AVG(DATEDIFF(r.close_date, r.open_date))), 'no info') AS average_duration
FROM reports AS r
INNER JOIN categories AS c ON c.id = r.category_id
INNER JOIN departments AS d ON d.id = c.department_id
GROUP BY d.name
ORDER BY d.name;