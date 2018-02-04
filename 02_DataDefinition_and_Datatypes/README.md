

# Data Types in MySQL Server
#### Numeric, String and Data Types
##### Numeric data types have certain range
#
>Their range can be changed if they are:  
Signed - represent numbers both in the positive and negative ranges  
Unsigned - represent number only in the positive range


 >INT [(M)] [UNSIGNED]  
 TINYNT, SMALLINT, MEDIUMINT, BIGINT  
 DOUBLE [(M, D)] [UNSIGNED]  
 E.g. DOUBLE[5, 2] – 999.99  
 DECIMAL [(M, D )] [UNSIGNED] [ZEROFILL]


##### String column definitions include attributes that specify the
#
 >character set or collation
 CHARACTER SET (Encoding)
 E.g. utf8, ucs2
 CHARACTER COLLATION – rules for encoding comparison
 E.g. latin1_general_cs, Traditional_Spanish_ci_ai etc.
 Set and collation can be defined at the database, table or column level

 >CHAR [(M)] - up to 30 characters
 VARCHAR(M) – up to 255 characters
 TEXT [(M)] – up to 65 535 characters
 TINYTEXT, MEDIUMTEXT, LONGTEXT
 BLOB - Binary Large OBject [(M)] - 65 535 (216 − 1) characters
 TINYBLOB, MEDIUMBLOB, LONGBLOB


|Column name | Column Type|
|---------|------------|
title     |   VARCHAR(CHAR)
content  |    TEXT(LONGTEXT)
picture  |    BLOB(LONGBLOB)

##### Date Types
#
>DATE - 	 for values with a date part but no time part
>TIME -     for values with time but no date part
>DATETIME - values that contain both date and time parts
>IMESTAMP  both date and time parts

|Column name  |     Column Type|
|---------|------------|
|birth date  |      DATE
last_time_online | TIMESTAMP
start_at     |     TIME
deleted_on    |    DATETIME

 MySQL retrieves values for a given date type in a standard output
 
|Data Type|Column Type|
|---------|------------|
|DATE     |    '0000-00-00'|
|TIME     |    '00:00:00'|
|DATETIME |    '0000-00-00 00:00:00'|
|TIMESTAMP |   '0000-00-00 00:00:00'|
|YEAR 	|	  0000|


#### Database Modeling

> We communicate with the database engine using SQL
> Queries provide greater control and flexibility
> To create a database using SQL:
> SQL keywords are conventionally capitalized


##### Table Creation in SQL
#
CREATE TABLE people
(
id INT NOT NULL,
email VARCHAR(50) NOT NULL,
first_name VARCHAR(50),
last_name VARCHAR(50)
);


##### Retrieve Records in SQL
#
SELECT * FROM employees;

SELECT first_name, last_name FROM employees
LIMIT 5;

##### Custom Column Properties
#
###### Primary Key:
     id INT NOT NULL PRIMARY KEY
 
###### Auto-Increment (Identity)
     id INT AUTO_INCREMENT PRIMARY KEY
 
###### Unique constraint – no repeating values in entire table
    email VARCHAR(50) UNIQUE
 
###### Default value – if not specified (otherwise set to NULL)
     balance DECIMAL(10,2) DEFAULT 0

##### Altering Tables Using SQL
#
>A table can be changed using the keywords ALTER TABLE

###### Add new column:
    ALTER TABLE employees
    ADD salary DECIMAL;

###### Modify data type of existing column:
    ALTER TABLE people
    MODIFY COLUMN email VARCHAR(100);

###### Delete existing column:
    ALTER TABLE people
    DROP COLUMN full_name;

###### Add primary key to existing column:
    ALTER TABLE people
    ADD CONSTRAINT pk_id
    PRIMARY KEY (id);

###### Add unique constraint:
    ALTER TABLE people
    ADD CONSTRAINT uq_email
    UNIQUE (email)

###### Set default value:
    ALTER TABLE people
    ALTER COLUMN balance SET DEFAULT 0;

##### Dropping and Truncating
#
> Deleting structures is called dropping
> You can drop keys, constraints, tables and entire databases
> Deleting all data in a table is called truncating
> Both of these actions cannot be undone – use with caution!

###### To delete all the entries in a table:
	TRUNCATE TABLE employees;
	
###### To drop a table – delete data and structure
	DROP TABLE employees;
###### To drop entire database
	DROP DATABASE soft_uni;

###### Primary keys, value constraints and unique fields
    ALTER TABLE employess
    DROP CONSTRAINT pk_id;

###### To remove DEFAULT value (if not specified, revert to NULL)
    ALTER TABLE employess
    ALTER COLUMN clients
    DROP DEFAULT;

