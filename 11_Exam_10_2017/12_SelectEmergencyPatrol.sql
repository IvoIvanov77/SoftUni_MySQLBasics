SELECT r.open_date, r.description, u.email AS reporter_email
FROM reports AS r
INNER JOIN categories AS c ON c.id = r.category_id
INNER JOIN departments AS d ON d.id = c.department_id
INNER JOIN users AS u ON u.id = r.user_id
WHERE r.close_date IS NULL 
AND LENGTH(r.description) > 20 AND r.description LIKE '%str%' 
AND d.name IN('Infrastructure', 'Emergency', 'Roads Maintenance')
ORDER BY r.open_date, u.email, r.id;
