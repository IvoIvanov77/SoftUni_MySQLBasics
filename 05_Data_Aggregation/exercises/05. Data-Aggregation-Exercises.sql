 
/*
1_Records’ Count
Import the database and send the total count of records to Mr. Bodrog. Make sure nothing got lost.
*/


SELECT COUNT(*) as count
from wizzard_deposits;

/*
2_Longest Magic Wand
Select the size of the longest magic wand. Rename the new column appropriately.
*/

SELECT MAX(magic_wand_size) as `longest_magic_wand`
from wizzard_deposits;


/*
3_Longest Magic Wand per Deposit Groups
For wizards in each deposit group show the longest magic wand. 
Sort result by longest magic wand for each deposit group in increasing order, 
then by deposit_group alphabetically.
 Rename the new column appropriately.
 */

SELECT deposit_group, MAX(magic_wand_size) AS `longest_magic_wand`
FROM wizzard_deposits
GROUP BY deposit_group
ORDER BY `longest_magic_wand` ASC, deposit_group;


/*
4_Smallest Deposit Group per Magic Wand Size*
Select the deposit group with the lowest average wand size.
*/

SELECT deposit_group
FROM wizzard_deposits
GROUP BY deposit_group
ORDER BY AVG(magic_wand_size)  ASC
LIMIT 1;


/*
5._Deposits Sum
Select all deposit groups and its total deposit sum. Sort result by total_sum in increasing order.
*/

SELECT deposit_group, SUM(deposit_amount) AS total_sum
FROM wizzard_deposits
GROUP BY deposit_group
ORDER BY total_sum  ASC;

/*
6_Deposits Sum for Ollivander family
Select all deposit groups and its total deposit sum but only for the wizards who has 
their magic wand crafted by Ollivander family. 
Sort result by deposit_group alphabetically.
*/

SELECT deposit_group, SUM(deposit_amount) AS total_sum
FROM wizzard_deposits
WHERE magic_wand_creator = 'Ollivander family'
GROUP BY deposit_group
ORDER BY deposit_group;

/*
7_Deposits Filter
Select all deposit groups and its total deposit sum but only for the wizards 
who has their magic wand crafted by Ollivander family. 
After this, filter total deposit sums lower than 150000. 
Order by total deposit sum in descending order.
*/

SELECT deposit_group, SUM(deposit_amount) AS total_sum
FROM wizzard_deposits
WHERE magic_wand_creator = 'Ollivander family'
GROUP BY deposit_group
HAVING total_sum < 150000
ORDER BY total_sum DESC;

/*
8_Deposit charge
Create a query that selects:
•	Deposit group 
•	Magic wand creator
•	Minimum deposit charge for each group 
Group by deposit_group and magic_wand_creator.
Select the data in ascending order by magic_wand_creator and deposit_group.
*/

SELECT deposit_group, magic_wand_creator, MIN(deposit_charge) AS min_deposit_charge
FROM wizzard_deposits
GROUP BY deposit_group, magic_wand_creator
ORDER BY magic_wand_creator, deposit_group;

/*
9_Age Groups
Write down a query that creates 7 different groups based on their age.
Age groups should be as follows:
•	[0-10]
•	[11-20]
•	[21-30]
•	[31-40]
•	[41-50]
•	[51-60]
•	[61+]
The query should return:
•	Age groups
•	Count of wizards in it
Sort result by increasing size of age groups.
*/

SELECT CASE
WHEN age >= 0 AND age <= 10 THEN '[0-10]'
WHEN age > 10 AND age <= 20 THEN '[11-20]'
WHEN age > 20 AND age <= 30 THEN '[21-30]'
WHEN age > 30 AND age <= 40 THEN '[31-40]'
WHEN age > 40 AND age <= 50 THEN '[41-50]'
WHEN age > 50 AND age <= 60 THEN '[51-60]'
WHEN age > 60 THEN '[61+]' END AS age_group,
COUNT(id) AS wizard_count
FROM wizzard_deposits
GROUP BY age_group;

/*
10_First Letter
Write a query that returns all unique wizard first letters of their first names 
only if they have deposit of type Troll Chest. 
Order them alphabetically. Use GROUP BY for uniqueness.
*/

SELECT
LEFT(first_name,1) AS first_letter
FROM wizzard_deposits
WHERE deposit_group = 'Troll Chest'
GROUP BY first_letter
ORDER BY first_letter;

/*
11_Average Interest 
Mr. Bodrog is highly interested in profitability. He wants to know the average interest of all deposits groups 
split by whether the deposit has expired or not. But that’s not all. 
He wants you to select deposits with start date after 01/01/1985. 
Order the data descending by Deposit Group and ascending by Expiration Flag.
*/

SELECT deposit_group, is_deposit_expired, AVG(deposit_interest) AS 'average_interest'
FROM wizzard_deposits
WHERE(deposit_start_date > '1985-01-01 00:00:00')
GROUP BY deposit_group, is_deposit_expired
ORDER BY deposit_group DESC, is_deposit_expired;

/*
12_Rich Wizard, Poor Wizard*
Give Mr. Bodrog some data to play his favorite game Rich Wizard, Poor Wizard. The rules are simple: 
You compare the deposits of every wizard with the wizard after him. 
If a wizard is the last one in the database, simply ignore it. At the end you have to sum the difference between the deposits.
At the end your query should return a single value: the SUM of all differences.
*/


SELECT id as curent_id, SUM(deposit_amount - (
SELECT deposit_amount
FROM wizzard_deposits
WHERE id = curent_id  + 1)) AS sum_difference
FROM wizzard_deposits;


/*
13_Employees Minimum Salaries
That’s it! You no longer work for Mr. Bodrog. You have decided to find a proper job as an analyst in SoftUni. 
It’s not a surprise that you will use the soft_uni database. 
Select the minimum salary from the employees for departments with ID (2,5,7) but only for those who are hired after 01/01/2000. 
Sort result by department_id in ascending order.
*/

SELECT department_id, MIN(salary) AS minimum_salary
FROM employees
WHERE department_id IN(2, 5, 7) AND YEAR(hire_date) >= 2000
GROUP BY department_id;

/*
14_Employees Average Salaries
Select all high paid employees who earn more than 30000 into a new table. 
Then delete all high paid employees who have manager_id = 42 from the new table; 
Then increase the salaries of all high paid employees with department_id =1 with 5000 in the new table. 
Finally, select the average salaries in each department from the new table. 
Sort result by department_id in increasing order.
*/

CREATE VIEW high_paid_employees AS
SELECT *
FROM employees
WHERE salary > 30000 AND manager_id != 42;

UPDATE high_paid_employees SET salary = salary + 5000
WHERE department_id = 1;

SELECT department_id, AVG(salary) AS avg_salary
FROM high_paid_employees
GROUP BY department_id;


/*15_Employees Maximum Salaries
Find the max salary for each department. Filter those which have max salaries not in the range 30000 and 70000. 
Sort result by department_id in increasing order.
*/


SELECT department_id, MAX(salary) AS max_salary
FROM employees
GROUP BY department_id
HAVING max_salary NOT BETWEEN 30000 AND 70000;


/*
16_Employees Count Salaries
Count the salaries of all employees who don’t have a manager.
*/

SELECT COUNT(salary)
FROM employees
WHERE manager_id IS NULL;

/*17_3rd Highest Salary*
Find the third highest salary in each department if there is such. Sort result by department_id in increasing order.
*/


--My solution:

SELECT e1.department_id, MAX(e1.salary)
FROM employees AS e1
WHERE e1.salary <
(
SELECT MAX(e2.salary)
FROM employees AS e2
WHERE e2.department_id = e1.department_id AND e2.salary <
(
SELECT MAX(e3.salary)
FROM employees AS e3
WHERE e3.department_id = e2.department_id
)

)
GROUP BY e1.department_id;


--Other solution:

SELECT e2.department_id, MAX(e2.salary)
FROM employees AS `e2`, (
SELECT e1.department_id AS 'dpid2', MAX(e1.salary) AS 'maxsal2', e1.first_name
FROM employees AS `e1`, (
SELECT e.department_id AS 'dpid', MAX(e.salary) AS 'maxsal', e.first_name
FROM employees AS `e`
GROUP BY e.department_id
) AS `first_sal`
WHERE(e1.department_id = dpid AND e1.salary < maxsal)
GROUP BY e1.department_id) AS second_sal
WHERE(e2.department_id = dpid2 AND e2.salary < maxsal2)
GROUP BY e2.department_id

/*
18_Salary Challenge**
Write a query that returns:
•	first_name
•	last_name
•	department_id
for all employees who have salary higher than the average salary of their respective departments. 
Select only the first 10 rows. Order by department_id.
*/

--My solution:

SELECT first_name, last_name, department_id
FROM employees AS empl
WHERE
empl.salary >
(
SELECT AVG(salary)
FROM employees
WHERE department_id = empl.department_id
)
ORDER BY empl.department_id, empl.employee_id
LIMIT 10;

--Other solution:

SELECT e1.first_name, e1.last_name, e1.department_id
FROM employees AS `e1`, (
SELECT e.department_id AS 'dpid', AVG(e.salary) AS 'avgsal'
FROM employees AS `e`
GROUP BY e.department_id) AS avg_sal
WHERE e1.department_id = dpid AND e1.salary > avgsal
ORDER BY e1.department_id
LIMIT 10;


/*
19_Departments Total Salaries
Create a query which shows the total sum of salaries for each department. Order by department_id.
*/


SELECT department_id, SUM(salary) AS total_salary
FROM employees
GROUP BY department_id;



