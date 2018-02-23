(
SELECT c.id AS id, c.name AS name, COUNT(uc.user_id) AS contestants
FROM contests AS c
LEFT JOIN users_contests AS uc ON uc.contest_id = c.id
GROUP BY c.id
ORDER BY contestants DESC
LIMIT 5)
ORDER BY contestants, id;