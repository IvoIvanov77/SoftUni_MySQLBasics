SELECT DISTINCT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS full_name,
tn.town_name
FROM customers AS c
INNER JOIN tickets AS t ON t.customer_id = c.customer_id
INNER JOIN flights AS f ON t.flight_id = f.flight_id
INNER JOIN airports AS a ON a.airport_id = f.origin_airport_id
INNER JOIN towns AS tn ON tn.town_id = a.town_id AND c.home_town_id = tn.town_id
WHERE f.`status` = 'Departing'
ORDER BY c.customer_id;


