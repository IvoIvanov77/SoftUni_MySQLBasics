SELECT c1.id, c1.name
FROM categories AS c
RIGHT JOIN categories AS c1 ON c.parent_id = c1.id
WHERE c.id IS NULL
ORDER BY c1.name, c1.id;