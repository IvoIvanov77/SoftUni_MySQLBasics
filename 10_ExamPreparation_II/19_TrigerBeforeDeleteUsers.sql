DELIMITER $$
CREATE TRIGGER delete_user 
BEFORE DELETE ON users 
FOR EACH ROW 
BEGIN
	DELETE m
	FROM messages AS m
	WHERE m.user_id = old.id;
	DELETE uc
	FROM users_chats AS uc
	WHERE uc.user_id = old.id; 
	DELETE ml
	FROM messages_log AS ml
	WHERE ml.user_id = old.id;
END$$