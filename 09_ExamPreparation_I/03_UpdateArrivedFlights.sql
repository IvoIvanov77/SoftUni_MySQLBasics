UPDATE flights AS f 
SET f.airline_id = 1
WHERE f.`status` = 'Arrived';