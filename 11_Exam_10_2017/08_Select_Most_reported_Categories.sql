SELECT c.name AS category_name, COUNT(*) AS reports_number
FROM reports AS r
INNER JOIN categories AS c ON c.id = r.category_id
GROUP BY r.category_id
ORDER BY reports_number, category_name;