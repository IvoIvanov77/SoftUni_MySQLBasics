#2/5
SELECT u.username
FROM reports AS r
INNER JOIN users AS u ON u.id = r.user_id
INNER JOIN categories AS c ON c.id = r.category_id
WHERE (u.username REGEXP '^[0-9]' AND c.id =
LEFT(u.username, 1)) 
OR (u.username REGEXP '[0-9]$' AND c.id =
RIGHT(u.username, 1))
ORDER BY u.username;
