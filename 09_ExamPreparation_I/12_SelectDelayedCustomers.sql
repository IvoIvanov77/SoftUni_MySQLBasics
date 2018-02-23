SELECT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) as full_name,
t.price, ap.airport_name
FROM customers AS c
INNER JOIN tickets AS t ON t.customer_id = c.customer_id
INNER JOIN flights AS f ON f.flight_id = t.flight_id
Inner join airports as ap on ap.airport_id = f.destination_airport_id
WHERE f.`status` = 'Delayed'
ORDER BY t.price DESC
LIMIT 3;