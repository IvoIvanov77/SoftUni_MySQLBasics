DELIMITER $$
CREATE PROCEDURE udp_change_password(user_email VARCHARACTER(30), 
 new_password VARCHARACTER(20)) 
BEGIN 
START TRANSACTION;
	IF(
	(SELECT COUNT(c.id)
	FROM credentials AS c
	WHERE c.email = user_email) = 0
	) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'The email does not exist!';
		ROLLBACK; 
	ELSE
	UPDATE credentials AS c SET c.`password` = `new_password`
	WHERE c.email = user_email; 
	END IF; 
END$$