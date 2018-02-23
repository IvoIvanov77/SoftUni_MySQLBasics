DELIMITER $$
CREATE FUNCTION ufn_user_with_most_contest()
	RETURNS INT
	BEGIN
		RETURN (SELECT u.id
			FROM users AS u
			WHERE (
			SELECT COUNT(uc.user_id) 
			FROM users_contests AS uc
			WHERE uc.user_id = u.id
			)  = (SELECT MAX(counted) FROM
					(
					    SELECT COUNT(*) AS counted
					    FROM users_contests AS us   
					    GROUP BY us.user_id
					) AS counts));
	END
$$


SELECT s.id, u.username, p.name, CONCAT(s.passed_tests, ' / ', p.tests) AS result
FROM submissions AS s
INNER JOIN users AS u ON u.id = s.user_id
INNER JOIN problems AS p ON p.id = s.problem_id
WHERE u.id = (
SELECT ufn_user_with_most_contest())
ORDER BY s.id DESC;
