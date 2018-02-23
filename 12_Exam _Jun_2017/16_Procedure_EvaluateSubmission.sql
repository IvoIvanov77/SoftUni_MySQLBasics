DELIMITER $$
CREATE PROCEDURE udp_evaluate(submission_id INT)
BEGIN
DECLARE id INT;
DECLARE problem_name VARCHARACTER(100);
DECLARE username VARCHARACTER(30);
DECLARE result INT;

	SET id := (
	SELECT s.id
	FROM submissions AS s
	WHERE s.id = submission_id);
	
	SET problem_name := (
	SELECT p.name
	FROM submissions AS s
	INNER JOIN problems AS p ON p.id = s.problem_id
	WHERE s.id = submission_id);
	
	SET username := (
	SELECT u.username
	FROM submissions AS s
	INNER JOIN users AS u ON u.id = s.user_id
	WHERE s.id = submission_id);
	
	SET result := (
	SELECT p.points / p.tests * s.passed_tests
	FROM submissions AS s
	INNER JOIN problems AS p ON p.id = s.problem_id
	WHERE s.id = submission_id);
	
	START TRANSACTION;
	IF(id IS NULL)
	THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Submission does not exist!';	
	ROLLBACK;
	ELSE
	insert into evaluated_submissions(id, problem, `user`, result) 
	values (id, problem_name, username, result);
	END IF;
END$$