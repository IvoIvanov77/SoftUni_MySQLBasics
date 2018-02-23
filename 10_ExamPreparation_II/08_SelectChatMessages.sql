SELECT c.id, c.title, m.id
FROM chats AS c
INNER JOIN messages AS m ON m.chat_id = c.id
WHERE m.sent_on < '2012-03-26' AND
RIGHT(c.title, 1) = 'x'
ORDER BY c.id, m.id;