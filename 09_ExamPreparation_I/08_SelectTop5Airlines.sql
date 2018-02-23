SELECT *
FROM airlines AS a
WHERE (
SELECT COUNT(f.airline_id)
FROM flights AS f
WHERE f.airline_id = a.airline_id) > 0
ORDER BY a.rating DESC, a.airline_id
LIMIT 5;