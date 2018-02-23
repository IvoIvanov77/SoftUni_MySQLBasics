SELECT DISTINCT c.name
FROM reports AS r
INNER JOIN users AS u ON u.id = r.user_id
INNER JOIN categories AS c ON c.id = r.category_id
WHERE DATE_FORMAT(r.open_date, '%m-%d') = DATE_FORMAT(u.birthdate, '%m-%d')
ORDER BY c.name;