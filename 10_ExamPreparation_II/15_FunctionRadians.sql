DELIMITER $$
CREATE FUNCTION udf_get_radians(`degrees` FLOAT) 
RETURNS FLOAT 
BEGIN 
	RETURN `degrees` * 	PI() / 180; 
END$$

