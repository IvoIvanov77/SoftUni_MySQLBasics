SELECT flight_id, departure_time, arrival_time, origin, destination
FROM(
	SELECT f.flight_id AS flight_id, f.departure_time AS departure_time, f.arrival_time AS arrival_time, 
	ao.airport_name AS origin, ad.airport_name AS destination
	FROM flights AS f
	INNER JOIN airports AS ao ON ao.airport_id = f.origin_airport_id
	INNER JOIN airports AS ad ON ad.airport_id = f.destination_airport_id
	WHERE f.`status` = 'Departing'
	ORDER BY departure_time DESC, flight_id DESC
	LIMIT 5
) AS sub
ORDER BY departure_time, flight_id;
	