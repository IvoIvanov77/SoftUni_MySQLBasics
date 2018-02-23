SELECT c.id, c.name, COUNT(s.id) AS `submissions`
FROM contests AS c
INNER JOIN problems AS p ON p.contest_id = c.id
INNER JOIN submissions AS s ON s.problem_id = p.id
INNER JOIN users_contests AS uc ON (uc.user_id = s.user_id AND
uc.contest_id = c.id)
GROUP BY c.id
ORDER BY `submissions` DESC, c.id;