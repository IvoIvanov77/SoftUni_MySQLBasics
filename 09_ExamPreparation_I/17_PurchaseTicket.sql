DELIMITER $$
CREATE PROCEDURE udp_purchase_ticket(customer_id INT, flight_id INT,
ticket_pricere DECIMAL(8,2), class VARCHARACTER(10), seat VARCHARACTER(10)) 
BEGIN 
START TRANSACTION; 
	IF(ticket_pricere > (
		SELECT balance
		FROM customer_bank_accounts AS cba
		WHERE cba.customer_id = customer_id)) 
		THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insufficient bank account balance for ticket purchase.'; 
		ROLLBACK; 
	ELSE
		INSERT INTO tickets(price, class, seat, customer_id, flight_id) 
		VALUES (ticket_pricere, class, seat, customer_id, flight_id);
		UPDATE customer_bank_accounts AS cba SET cba.balance = cba.balance - ticket_pricere; 
	END IF; 
END$$