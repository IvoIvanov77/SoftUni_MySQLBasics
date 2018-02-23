SELECT m.chat_id, COUNT(m.id) AS total_count
FROM messages AS m
WHERE m.id < 90
GROUP BY m.chat_id
ORDER BY total_count DESC, m.chat_id ASC
LIMIT 5;