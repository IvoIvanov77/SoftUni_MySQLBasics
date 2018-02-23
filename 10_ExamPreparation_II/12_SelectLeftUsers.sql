SELECT m.id, m.chat_id, m.user_id
FROM messages AS m
WHERE m.chat_id = 17 AND m.user_id NOT IN(
SELECT uc.user_id
FROM users_chats AS uc
WHERE uc.chat_id = 17
)
ORDER BY m.id DESC;
