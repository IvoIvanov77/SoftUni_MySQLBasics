SELECT e.first_name, e.last_name, r.description, 
DATE_FORMAT(r.open_date, '%Y-%m-%d') AS open_date
FROM reports AS r
INNER JOIN employees AS e ON e.id = r.employee_id
ORDER BY e.id, r.open_date, r.id;