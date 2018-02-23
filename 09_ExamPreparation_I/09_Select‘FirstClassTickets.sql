SELECT t.ticket_id, a.airport_name, CONCAT(c.first_name, ' ', c.last_name) 
AS full_name
FROM tickets AS t
INNER JOIN flights AS f ON f.flight_id = t.flight_id
INNER JOIN airports AS a ON a.airport_id = f.destination_airport_id
INNER JOIN customers AS c ON c.customer_id = t.customer_id
WHERE t.price < 5000 AND t.class = 'First'
ORDER BY t.ticket_id;