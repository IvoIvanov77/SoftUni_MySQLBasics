SELECT u.id, u.username, u.`password`
FROM users AS u
WHERE (
SELECT COUNT(u1.id)
FROM users AS u1
WHERE u.`password` = u1.`password`) > 1
ORDER BY u.username, u.id;