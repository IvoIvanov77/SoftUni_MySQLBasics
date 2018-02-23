SELECT r.description, r.open_date
FROM reports AS r
WHERE r.employee_id IS NULL
ORDER BY r.open_date, r.description;