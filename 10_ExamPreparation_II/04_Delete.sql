DELETE l
FROM locations AS l
LEFT JOIN users AS u ON l.id = u.location_id
WHERE u.id IS NULL;