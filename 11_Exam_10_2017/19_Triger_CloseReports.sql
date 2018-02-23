DELIMITER $$
CREATE TRIGGER tr_close_reports 
BEFORE
UPDATE ON reports
FOR EACH ROW 
BEGIN
	IF old.close_date is null and new.close_date is not null
	THEN
	SET new.status_id = 3;
	END IF;
END $$