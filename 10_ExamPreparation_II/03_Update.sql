UPDATE chats AS c
INNER JOIN messages AS m 
ON m.chat_id = c.id
SET c.start_date = m.sent_on
WHERE m.sent_on < c.start_date;