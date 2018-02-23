#6/10 judge
SELECT c.title, m.content
FROM chats AS c
LEFT JOIN messages AS m ON m.chat_id = c.id
WHERE c.start_date = (
SELECT MAX(c1.start_date)
FROM chats AS c1
)
ORDER BY m.id;

--must be ordered by sent_on

#10/10 judge
SELECT c.title, m.content
FROM `chats` AS c
LEFT OUTER JOIN `messages` AS m
ON c.id = m.chat_id
WHERE c.start_date = (SELECT MAX(c.start_date) FROM `chats` AS c)
ORDER BY m.sent_on ASC, m.id ASC;

#10/10 judge
SELECT c.title, m.content
FROM `chats` AS c
LEFT OUTER JOIN `messages` AS m
ON c.id = m.chat_id
WHERE c.id = (SELECT c.id FROM `chats` AS c ORDER BY c.start_date DESC LIMIT 1)
ORDER BY m.sent_on ASC, m.id ASC;
