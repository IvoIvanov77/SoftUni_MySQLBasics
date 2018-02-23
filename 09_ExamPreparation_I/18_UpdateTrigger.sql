DELIMITER $$
CREATE FUNCTION ufn_passengers_count(flight_id INT)
	RETURNS INT
	BEGIN
		RETURN (select count(t.customer_id) from tickets as t where t.flight_id = flight_id);
	END$$

DELIMITER $$
CREATE TRIGGER tr_change_status
BEFORE UPDATE
ON flights
FOR EACH ROW
BEGIN
	if old.`status` != 'Arrived' and old.`status` != 'Cancelled' and new.`status` = 'Arrived'
	THEN
	INSERT INTO arrived_flights(flight_id, arrival_time, origin,
	destination, passengers)
	VALUES (new.flight_id, new.arrival_time, 
	(select ap.airport_name from airports as ap where ap.airport_id = new.origin_airport_id),
	(select ap1.airport_name from airports as ap1 where ap1.airport_id = new.destination_airport_id), 
	(select ufn_passengers_count(new.flight_id)));	
	END IF;
END $$