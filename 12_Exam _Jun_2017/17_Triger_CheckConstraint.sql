DELIMITER $$

CREATE TRIGGER before_insert_problem
     BEFORE INSERT ON problems FOR EACH ROW
     BEGIN
          IF LOCATE(' ', NEW.name, 1) = 0
          	THEN
               SIGNAL SQLSTATE '45000'
                    SET MESSAGE_TEXT = 'The given name is invalid!';
          ELSEIF NEW.points <= 0 
          	THEN
               SIGNAL SQLSTATE '45000'
                    SET MESSAGE_TEXT = 'The problem’s points cannot be less or equal to 0!';
          ELSEIF NEW.tests <= 0 
          	THEN
               SIGNAL SQLSTATE '45000'
                    SET MESSAGE_TEXT = 'The problem’s tests cannot be less or equal to 0!';
          END IF;
     END;
$$