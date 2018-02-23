DELIMITER $$
CREATE PROCEDURE udp_login(uname VARCHARACTER(50), 
pass VARCHARACTER(50))
BEGIN
DECLARE id INT;
DECLARE email VARCHARACTER(50);
	SET id := (
	SELECT u.id
	FROM users as u
	WHERE u.username = uname);	
	SET email := (
	SELECT u.email
	FROM users as u
	WHERE u.username = uname);
	START TRANSACTION;
	IF(id IS NULL)
		THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Username does not exist!';
		ROLLBACK;
	ELSEIF((select u.password from users as u where u.username = uname) != pass)	
		THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Password is incorrect!';
		ROLLBACK;
	ELSEIF((SELECT COUNT(lu.id) FROM logged_in_users as lu where lu.username = uname) > 0)
		THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'User is already logged in!';
	ROLLBACK;
	ELSE
	INSERT INTO logged_in_users(id, username, `password`,
	email) VALUES (id, uname, pass, email);
	END IF;
END$$