SELECT ap.airport_id, ap.airport_name, COUNT(t.customer_id) AS passengers
FROM tickets AS t
INNER JOIN flights AS f ON f.flight_id = t.flight_id
INNER JOIN airports AS ap ON ap.airport_id = f.origin_airport_id
WHERE f.`status` = 'Departing'
GROUP BY ap.airport_name
ORDER BY ap.airport_id;

