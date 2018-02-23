SELECT DISTINCT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS full_name,
(2016 - YEAR(c.date_of_birth)) AS age
FROM customers AS c
INNER JOIN tickets AS t ON t.customer_id = c.customer_id
INNER JOIN flights AS f ON f.flight_id = t.flight_id
WHERE f.`status` = 'Departing'
ORDER BY age, c.customer_id;