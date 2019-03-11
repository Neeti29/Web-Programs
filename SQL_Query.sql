use classicmodels;

/*
select c.id,c.first_name,s.name as 'Skills'
from candidates c
inner Join skills s on c.id=s.id;

select c.id,c.first_name,s.name as 'Skills'
from candidates c
left outer Join skills s on c.id=s.id;

select c.id,c.first_name,s.name as 'Skills'
from candidates c
right outer Join skills s on c.id=s.id;


select c.id,c.first_name, sk.skill_id
from candidates c
Join candidate_skills sk on 
c.id=sk.candidate_id;

select c.id,c.first_name, sk.skill_id
from candidates c
left outer Join candidate_skills sk on 
c.id=sk.candidate_id;

select c.id,c.first_name, sk.skill_id
from candidates c
right outer Join candidate_skills sk on 
c.id=sk.candidate_id;

select c.id,c.first_name, s.name as "skills"
from candidates c
Join candidate_skills sk on 
c.id=sk.candidate_id
join 
skills s on s.id=sk.skill_id;
*/

/*Index queries*/

select employeeNumber, lastName, firstName 
from employees
where jobTitle='sales Rep';

explain select employeeNumber, lastName, firstName 
from employees
force index(jtIndx)
where jobTitle='sales Rep';


CREATE INDEX jtIndx on EMPLOYEES(JOBTITLE);

SHOW INDEXES FROM EMPLOYEES;

select employeeNumber, lastName, firstName 
from employees
force index(jtIndx)
where jobTitle='sales Rep';

/*Procedures*/

DELIMITER $$;
CREATE PROCEDURE GetAllProducts1()

		SELECT * FROM PRODUCTS;
		
CALL GetAllProducts1()
	
CREATE PROCEDURE CountEmployees()

	SELECT COUNT(*) AS "No. of Employees"
		FROM employees;
	
CALL CountEmployees()


SET @A=10;
	
	SELECT @A;

CREATE PROCEDURE GetOfficeByCountry(IN cn VARCHAR(255))
	SELECT *
		FROM OFFICES 
		WHERE COUNTRY=cn;
		
CALL GetOfficeByCountry('Japan');

CREATE PROCEDURE CountEmployeesCountry(IN cn VARCHAR(255))

	SELECT COUNT(*) AS "No. of Employees"
		FROM employees e
		JOIN offices o
		on e.officeCode=o.officeCode
		WHERE o.country=cn;
	
CALL CountEmployeesCountry('Australia');


CREATE PROCEDURE CountOrderByStatus(IN os VARCHAR(25),OUT total INT)
SELECT COUNT(ORDERNUMBER) INTO total FROM 
ORDERS
WHERE STATUS=os;

CALL CountOrderByStatus('Cancelled',@total);
SELECT @total;

CREATE FUNCTION TEST(A INT) RETURNS INT
RETURN A*A

SELECT TEST(20)

CREATE FUNCTION CustomerLevel(pc double) RETURNS VARCHAR(10)
		IF pc > 50000 then
			return 'PLATINUM';
		
	ELSEIF(pc<=50000 AND pc>=10000) then
		return 'GOLD';
		
	ELSEIF(pc<10000) then
		return 'SILVER';

	END IF;	

CREATE TABLE EMPLOYEES_AUDIT1(
	ID INT AUTO_INCREMENT PRIMARY KEY,
	EMPLOYEENUMBER INT NOT NULL,
	LASTNAME VARCHAR(50) NOT NULL,
	CHANGEDAT DATETIME DEFAULT NULL,
	ACTION VARCHAR(50) DEFAULT NULL);
	
CREATE OR REPLACE TRIGGER before_employee_update 
	BEFORE UPDATE ON EMPLOYEES
	
	
	FOR EACH ROW 
	INSERT INTO EMPLOYEES_AUDIT1 SET ACTION ='update',
	employeenumber=OLD.employeenumber,
	lastname=OLD.LASTNAME,
	CHANGEDAT=NOW();
	
	SHOW TRIGGERS;
	
	UPDATE EMPLOYEES SET LASTNAME='Neeti1'
	WHERE employeeNumber=1337;





