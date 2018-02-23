DELIMITER $$
CREATE PROCEDURE udp_submit_review(customer_id INT, 
review_content VARCHARACTER(255), review_grade INT, name VARCHARACTER(50))
BEGIN
DECLARE id INT;
	SET id := (
	SELECT airline_id
	FROM airlines as a
	WHERE a.airline_name = name);
	START TRANSACTION;
	IF(id IS NULL)
	THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Airline does not exist.';	
	ROLLBACK;
	ELSE
	insert into customer_reviews(review_content, review_grade, airline_id,
	customer_id) values (review_content, review_grade, id, customer_id);
	END IF;
END$$