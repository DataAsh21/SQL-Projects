CREATE DATABASE Employee;

Use Employee
create table Employee_Details(
        Emp_ID int primary key,
		FullName varchar(100),
		Manager_ID int,
		Date_of_joining DATE,
		Month_Number INT,
		Month_Name VARCHAR(20),
		Year INT,
);

ALTER TABLE [dbo].[Employee_Details]
ADD CITY VARCHAR(100);
UPDATE  [dbo].[Employee_Details]
SET CITY = 'TORNATO'
WHERE Emp_ID = 121;

CREATE TABLE Employee_Salary(
      Emp_ID int primary key,
	  Foreign key (EMP_ID) references Employee_Details(Emp_ID),
	  Project Varchar(50),
	  Salary int,
	  Variable int,
);

DROP TABLE Employee_Salary
Insert into Employee_Details(Emp_ID,FullName,Manager_ID,Date_of_joining,Month_Number,Month_Name,Year)
Values
     (121,'John Snow',321,'01-31-2019',1,'January',2019),
	 (321,'Walter White',986,'01-30-2020',1,'January',2020),
	 (421,'Kuldeep Rana',876,'11-27-2021',11,'November',2021);

select COUNT(*)
from Employee_Details
WHERE[Date_of_joining] BETWEEN '01-31-2019' AND '01-30-2020'

UPDATE  [dbo].[Employee_Details]
SET CITY = 'TORONTO'
WHERE Emp_ID = 121;
UPDATE  [dbo].[Employee_Details]
SET CITY = 'CALIFORNIA'
WHERE Emp_ID = 321;
UPDATE  [dbo].[Employee_Details]
SET CITY = 'NEW DELHI'
WHERE Emp_ID = 421;

INSERT INTO Employee_Salary(Emp_ID,Project,Salary,Variable)
Values
     (121,'P1',8000,500),
	 (321,'P2',10000,1000),
	 (421,'P1',12000,0);


SELECT*FROM Employee_Salary;

/*Task nos - 1
Q1)SQL Query to fetch records that are present in one table but not in another table.*/
SELECT*
FROM Employee_Details
LEFT JOIN [dbo].[Employee_Salary] ON Employee_Details.Emp_ID=[dbo].[Employee_Salary].[Emp_ID]
WHERE [dbo].[Employee_Salary].[Emp_ID] IS NOT  NULL;

--Q2)SQL query to fetch all the employees who are not working on any project.
SELECT*
FROM Employee_Details
LEFT JOIN [dbo].[Employee_Salary] ON Employee_Details.Emp_ID=[dbo].[Employee_Salary].[Emp_ID]
WHERE [dbo].[Employee_Salary].[Project] IS  NULL;

--Q3)SQL query to fetch all the Employees from EmployeeDetails who joined in the Year 2020.
SELECT*
FROM Employee_Details
LEFT JOIN [dbo].[Employee_Salary] ON Employee_Details.Emp_ID=[dbo].[Employee_Salary].[Emp_ID]
WHERE [dbo].[Employee_Details].Year = 2020;

--2ND METHOD

SELECT*
FROM Employee_Details
LEFT JOIN [dbo].[Employee_Salary] ON Employee_Details.Emp_ID=[dbo].[Employee_Salary].[Emp_ID]
WHERE YEAR([Date_of_joining]) = 2020

--Q4)Fetch all employees from EmployeeDetails who have a salary record in EmployeeSalary.
SELECT*
FROM Employee_Details
INNER JOIN [dbo].[Employee_Salary] ON Employee_Details.Emp_ID=[dbo].[Employee_Salary].[Emp_ID]

--Q5)Write an SQL query to fetch a project-wise count of employees.
SELECT Project,COUNT(*) AS PROJECT_COUNT
FROM [dbo].[Employee_Salary]
GROUP BY PROJECT;

--Q6)Fetch employee names and salaries even if the salary value is not present for the employee.
SELECT [dbo].[Employee_Details].[FullName],[dbo].[Employee_Salary].[Salary]
FROM Employee_Details
LEFT JOIN [dbo].[Employee_Salary] ON Employee_Details.Emp_ID=[dbo].[Employee_Salary].[Emp_ID]
WHERE [dbo].[Employee_Salary].[Salary] IS NULL;

--Q7)Write an SQL query to fetch all the Employees who are also managers.
SELECT e.*
FROM Employee_Details e
INNER JOIN Employee_Details m ON e.Emp_ID = m.Manager_ID;
-- 2nd method
SELECT *
from [dbo].[Employee_Details] 
where Emp_ID in ( select Manager_ID from [dbo].[Employee_Details]);

--Q8)Write an SQL query to fetch duplicate records from EmployeeDetails.
SELECT *
FROM Employee_Details
inner join(
     SELECT Emp_ID
	 from Employee_Details
	 group by Emp_ID
	 having COUNT(*)>1
)AS DuplicateEmployeeIDs
on Employee_Details.Emp_ID = DuplicateEmployeeIDs.Emp_ID;
-- or method

select Emp_id,FullName
from Employee_Details
group by Emp_ID,FullName
having COUNT(*)>1;

--Q9)Write an SQL query to fetch only odd rows from the table.
SELECT *
FROM (
    SELECT *, ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS RowNum
    FROM Employee_Details
) AS NumberedRows
WHERE RowNum % 2 =1;

select *
from [dbo].[Employee_Details]
where Emp_ID %  2 <> 0;

--Q10)Write a query to find the 3rd highest salary from a table without top or limit keyword.
SELECT SALARY
FROM(
  SELECT  SALARY, ROW_NUMBER() OVER (ORDER BY SALARY DESC)AS ROWNUM
  FROM [dbo].[Employee_Salary]
) AS SUBQUERY
WHERE ROWNUM = 3;
--Task nos  - 2
--Ques.1. Write an SQL query to fetch the EmpId and FullName of all the employees working under the Manager with id – ‘986’.
SELECT Emp_ID, FullName
from Employee_Details
where Manager_ID = 986;

--Ques.2. Write an SQL query to fetch the different projects available from the EmployeeSalary table.
select DISTINCT(Project)
FROM [dbo].[Employee_Salary]

--Ques.3. Write an SQL query to fetch the count of employees working in project ‘P1’.
SELECT PROJECT, COUNT(*) AS PROJECT_COUNT
FROM [dbo].[Employee_Salary]
WHERE PROJECT = 'P1'
GROUP BY PROJECT;

--Ques.4. Write an SQL query to find the maximum, minimum, and average salary of the employees.
SELECT MIN(SALARY) AS MIN_SALARY, MAX(SALARY) AS MAX_SALARY, AVG(SALARY) AS AVG_SALARY
FROM [dbo].[Employee_Salary];

SELECT * FROM [dbo].[Employee_Salary]

--Ques.5. Write an SQL query to find the employee id whose salary lies in the range of 9000 and 15000.
SELECT Emp_ID , SALARY
from [dbo].[Employee_Salary]
where Salary BETWEEN 9000 AND 15000;

--Ques.6. Write an SQL query to fetch those employees who live in Toronto and work under the manager with ManagerId – 321.
SELECT *
FROM Employee_Details
WHERE CITY = 'TORONTO' AND Manager_ID = 321;

/*Ques.7. Write an SQL query to fetch all the employees who either live
in California or work under a manager with ManagerId – 321.*/
SELECT*
FROM Employee_Details
WHERE CITY = 'CALIFORNIA' OR Manager_ID = 321;

--Ques.8. Write an SQL query to fetch all those employees who work on Projects other than P1.
SELECT *
FROM [dbo].[Employee_Salary]
WHERE PROJECT <> 'P1'

--Ques.9. Write an SQL query to display the total salary of each employee adding the Salary with Variable value.
SELECT Emp_ID,Project , SUM(Salary + Variable) AS TOTAL_SALARY
FROM [dbo].[Employee_Salary] 
group by Emp_ID, Project;

/*Ques.10. Write an SQL query to fetch the employees whose name begins with any two characters, 
followed by a text “hn” and ends with any sequence of characters.*/
SELECT *
FROM [dbo].[Employee_Details]
WHERE FullName LIKE '__hn%'

/*Task nos  - 3
Ques.1 Write an SQL query to fetch all the EmpIds which are present in either of the tables – 
‘EmployeeDetails’ and ‘EmployeeSalary’.*/
select [dbo].[Employee_Details].Emp_ID
from [dbo].[Employee_Details]
left join [dbo].[Employee_Salary] on [dbo].[Employee_Details].Emp_ID = [dbo].[Employee_Salary].Emp_ID

--Ques.2 Write an SQL query to fetch common records between two tables.
select*
from [dbo].[Employee_Details]
inner join [dbo].[Employee_Salary] on [dbo].[Employee_Details].Emp_ID = [dbo].[Employee_Salary].Emp_ID

--Ques.3. Write an SQL query to fetch records that are present in one table but not in another table.
select*
from [dbo].[Employee_Details]
left join [dbo].[Employee_Salary] on [dbo].[Employee_Details].Emp_ID = [dbo].[Employee_Salary].Emp_ID
where Employee_Details.Emp_ID is null;

--Ques.4. Write an SQL query to fetch the EmpIds that are present in both the tables –  ‘EmployeeDetails’ and ‘EmployeeSalary.
select*
from [dbo].[Employee_Details]
full outer join [dbo].[Employee_Salary] on [dbo].[Employee_Details].Emp_ID = [dbo].[Employee_Salary].Emp_ID

--Ques.5. Write an SQL query to fetch the EmpIds that are present in EmployeeDetails but not in EmployeeSalary.
select*
from [dbo].[Employee_Details]
left join [dbo].[Employee_Salary] on [dbo].[Employee_Details].Emp_ID = [dbo].[Employee_Salary].Emp_ID
where Employee_Details.Emp_ID is null;

--Ques.6. Write an SQL query to fetch the employee’s full names and replace the space
SELECT FullName,
       REPLACE(FullName, ' ', '_') AS ModifiedFullName
FROM Employee_Details;

--Ques.7. Write an SQL query to fetch the position of a given character(s) in a field.
select CHARINDEX('s', "FullName") as char_position
from [dbo].[Employee_Details]

select*from [dbo].[Employee_Details]

--Ques.8. Write an SQL query to display both the EmpId and ManagerId together.
select Emp_ID, Manager_ID
from Employee_Details;

/*Ques.9. Write a query to fetch only the first name(string before space) 
from the FullName column of the EmployeeDetails table.*/
SELECT
    LEFT(FullName, CHARINDEX(' ', FullName ) - 1) AS Part1,
	SUBSTRING(FullName, CHARINDEX(' ', FullName) + 1, LEN(FullName)) AS Part2
FROM[dbo].[Employee_Details] ;
--2nd method
SELECT
    LEFT(FullName, CHARINDEX(' ', FullName ) - 1) AS Part1,
	right(FullName,CHARINDEX(' ', FullName ) -1) as Part2
From [dbo].[Employee_Details]
--Ques.10. Write an SQL query to uppercase the name of the employee and lowercase the city values.
select upper(FullName) as Upper_Name, LOWER(city) as Lower_city
from Employee_Details

--Task nos- 4
--Ques.1. Write an SQL query to find the count of the total occurrences of a particular character – ‘n’ in the FullName field.
SELECT 
    LEN(FullName) - LEN(REPLACE(FullName, 'n', '_ID')) AS CountOf_n
FROM [dbo].[Employee_Details];

--Ques.2. Write an SQL query to update the employee names by removing leading and trailing spaces.
Update[dbo].[Employee_Details]
set FullName = TRIM(FullName);

--Ques.3. Fetch all the employees who are not working on any project.
SELECT*
FROM Employee_Details
LEFT JOIN [dbo].[Employee_Salary] ON Employee_Details.Emp_ID=[dbo].[Employee_Salary].[Emp_ID]
WHERE [dbo].[Employee_Salary].[Project] IS  NULL;

/*Ques.4. Write an SQL query to fetch employee names having a salary greater than or equal to 5000
and less than or equal to 10000.*/

select [dbo].[Employee_Details].FullName,[dbo].[Employee_Salary].[Salary]
from [dbo].[Employee_Details]
Full outer join [dbo].[Employee_Salary] on [dbo].[Employee_Details].Emp_ID = [dbo].[Employee_Salary].[Emp_ID]
where [dbo].[Employee_Salary].[Salary] >= 5000 and [dbo].[Employee_Salary].[Salary] <= 10000; 

select*from [dbo].[Employee_Salary]

--Ques.5. Write an SQL query to find the current date-time.
select GETDATE() as current_date_time

--Ques.6. Write an SQL query to fetch all the Employee details from the EmployeeDetails table who joined in the Year 2020.
SELECT*
FROM Employee_Details
LEFT JOIN [dbo].[Employee_Salary] ON Employee_Details.Emp_ID=[dbo].[Employee_Salary].[Emp_ID]
WHERE [dbo].[Employee_Details].Year = 2020;

--Ques.7. Write an SQL query to fetch all employee records from the EmployeeDetails table who have a salary record in the EmployeeSalary table.
SELECT*
FROM Employee_Details
INNER JOIN [dbo].[Employee_Salary] ON Employee_Details.Emp_ID=[dbo].[Employee_Salary].[Emp_ID]

--Ques.8. Write an SQL query to fetch the project-wise count of employees sorted by project’s count in descending order.
SELECT Project, count(*) As Project_count
From [dbo].[Employee_Salary]
group by  Project
order by Project_count desc;

/*Ques.9. Write a query to fetch employee names and salary records. 
Display the employee details even if the salary record is not present for the employee.*/
SELECT [dbo].[Employee_Details].FullName,[dbo].[Employee_Salary].[Salary]
FROM [dbo].[Employee_Details]
LEFT JOIN  [dbo].[Employee_Salary] ON [dbo].[Employee_Details].Emp_ID =[dbo].[Employee_Salary].[Emp_ID]

--Ques.10. Write an SQL query to join 3 tables.
----------------------------------------------------------------------------------------------------------------------------------------------------------
--Advanced Task 
-- create table Employeeinfo table
CREATE TABLE Employeeinfo(
         Emp_Id int primary key,
		 Emp_Fname varchar(50),
		 Emp_Lname Varchar(50),
		 Department Varchar(50),
		 Project Varchar(50),
		 Address varchar (100),
		 DOB DATE ,
		 Gender varchar(20)
);

--create table EmployeePosition Table
CREATE TABLE EmployeePosition(
          Emp_ID int ,
		  Emp_Position varchar(50),
		  Date_Of_Joining DATE,
		  Salary int
);

--INSERTING RECORDS IN  Employeeinfo table
INSERT INTO Employeeinfo(Emp_Id,Emp_Fname,Emp_Lname,Department,Project,Address ,DOB,Gender)
VALUES
     (1,'Sanjay','Mehra','HR','P1','Hyderabad(HYD)','01-12-1976','M'),
	 (2,'Ananya','Mishra','Admin','P2','Delhi(DEL)','02-05-1968','F'),
	 (3,'Rohan','Diwan','Account','P3','Mumbai(BOM)','01-01-1980','M'),
	 (4,'Sonia','Kulkarni','HR','P1','Hyderabad(HYD)','02-05-1992','F'),
	 (5,'Ankit','Kapoor','Admin','P2','Delhi(DEL)','03-07-1994','M');

SELECT*FROM Employeeinfo
SELECT YEAR(DOB)FROM Employeeinfo
ALTER  TABLE Employeeinfo
ALTER COLUMN DOB DATE;

INSERT INTO EmployeePosition(Emp_ID,Emp_Position,Date_Of_Joining,Salary)
VALUES
     (1,'Manager','01-05-2022', 500000),
	 (2,'Executive','02-05-2022',75000),
	 (3,'Manager','01-05-2022',90000),
	 (2,'Lead','02-05-2022',85000),
	 (1,'Executive','01-05-2022',300000);

select*from EmployeePosition
ALTER TABLE EmployeePosition
ALTER COLUMN Date_Of_Joining DATE;
--Q1)Write a query to fetch the EmpFname from the EmployeeInfo table in the upper case and use the ALIAS name as EmpName.
SELECT UPPER(Emp_Fname) AS EmpName
from [dbo].[Employeeinfo]

--Q2)Write a query to fetch the number of employees working in the department ‘HR’.
SELECT COUNT(*) AS NUMBER_OF_EMPLOYEE_HR
FROM[dbo].[Employeeinfo]
WHERE Department='HR'

--Q3)Write a query to get the current date.
SELECT GETDATE() AS CURRENTDATE

--Q4)Write a query to retrieve the first four characters of  EmpLname from the EmployeeInfo table.
SELECT LEFT([Emp_Lname],4) AS EmpLname
FROM [dbo].[Employeeinfo]

--Q5)Write a query to fetch only the place name(string before brackets) from the Address column of EmployeeInfo table.

SELECT
    LEFT([Address], CHARINDEX('(', [Address]) -1) AS PlaceName
	
FROM [dbo].[EmployeeInfo];
--from below query we can retrive (name)
SELECT RIGHT([Address],5) AS PlaceName
FROM [dbo].[Employeeinfo]

--Q6)Write a query to create a new table that consists of data and structure copied from the other table.
SELECT*
INTO NEW_TABLE_Employeeinfo
FROM [dbo].[Employeeinfo]

select*from NEW_TABLE_Employeeinfo

--Q7)Write q query to find all the employees whose salary is between 50000 to 100000.
select*
from[dbo].[EmployeePosition]
where [Salary] between 50000 and 100000;

--Q8)Write a query to find the names of employees that begin with ‘S’
SELECT*
FROM[dbo].[Employeeinfo]
WHERE [Emp_Fname] LIKE 'S%';

--Q9)Write a query to fetch top N records.
SELECT TOP 2*
FROM [dbo].[Employeeinfo]

SELECT TOP 50 PERCENT*
FROM [dbo].[Employeeinfo]

/*Q10)Write a query to retrieve the EmpFname and EmpLname in a single column as “FullName”. 
The first name and the last name must be separated with space.*/
SELECT CONCAT([Emp_Fname],'  ',[Emp_Lname]) AS FullName
FROM [dbo].[Employeeinfo]

SELECT CONCAT_WS('  ',[Emp_Fname],[Emp_Lname]) AS FullName
FROM [dbo].[Employeeinfo]

/*Q11. Write a query find number of employees whose DOB is between 02/05/1970 to 31/12/1975 
and are grouped according to gender*/
SELECT GENDER,COUNT(GENDER)  NUMBER_OF_EMPLOYEE
FROM [dbo].[Employeeinfo]
WHERE [DOB] BETWEEN '1970-05-02' AND '1976-12-01'
GROUP BY [Gender]

SELECT*FROM [dbo].[Employeeinfo]

/*Q12. Write a query to fetch all the records from the EmployeeInfo table ordered by EmpLname 
in descending order and Department in the ascending order.*/
SELECT*
FROM [dbo].[Employeeinfo]
ORDER BY [Emp_Lname] DESC,[Department] ASC;

/*Q13. Write a query to fetch details of employees whose EmpLname ends with an alphabet ‘A’
and contains five alphabets.*/
SELECT*
FROM [dbo].[Employeeinfo]
WHERE [Emp_Lname] LIKE '____A'

/*Q14. Write a query to fetch details of all employees excluding the employees with first names,
“Sanjay” and “Sonia” from the EmployeeInfo table.*/
SELECT*
FROM [dbo].[Employeeinfo]
WHERE [Emp_Fname] NOT IN ('Sanjay','Sonia')

--Q15. Write a query to fetch details of employees with the address as “DELHI(DEL)”.
SELECT*
FROM [dbo].[Employeeinfo]
WHERE [Address] = 'DELHI(DEL)';

--Q16. Write a query to fetch all employees who also hold the managerial position.
SELECT*
FROM [dbo].[EmployeePosition]
WHERE [Emp_ID] in (SELECT[Emp_ID] FROM [dbo].[EmployeePosition] WHERE[Emp_Position] = 'Manager' )


--Q17. Write a query to fetch the department-wise count of employees sorted by department’s count in ascending order.
SELECT DEPARTMENT ,COUNT(*) AS DEPT_COUNT
FROM [dbo].[Employeeinfo]
GROUP BY [Department]
ORDER BY [Department] ASC;

--Q18. Write a query to calculate the even and odd records from a table.
--- for odd
SELECT *
FROM (
    SELECT *, ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS RowNum
    FROM [dbo].[Employeeinfo]
) AS NumberedRows
WHERE RowNum % 2 =1;
--- for even 
SELECT*
FROM(
    SELECT *, ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS RowNum
	from [dbo].[Employeeinfo]
) As NumberedRows
WHERE RowNum % 2 = 0;

/*Q19. Write a SQL query to retrieve employee details from EmployeeInfo table who have a date of joining 
in the EmployeePosition table.*/

SELECT*
FROM [dbo].[Employeeinfo]
WHERE [Emp_Id] IN (SELECT [Emp_ID] FROM [dbo].[EmployeePosition])

SELECT*FROM [dbo].[EmployeePosition]

--Q20. Write a query to retrieve two minimum and maximum salaries from the EmployeePosition table.
SELECT TOP 2 [Salary]
FROM [dbo].[EmployeePosition]
ORDER BY [Salary] ASC;

SELECT TOP 2 [Salary]
FROM[dbo].[EmployeePosition]
ORDER BY [Salary] DESC;

--Q21. Write a query to find the Nth highest salary from the table without using TOP/limit keyword.
SELECT SALARY
FROM (
   SELECT [Salary],ROW_NUMBER() OVER (ORDER BY [Salary] DESC) AS ROWNUM
   FROM [dbo].[EmployeePosition]
)AS SUBQUERY
WHERE ROWNUM = 1;

--Q22. Write a query to retrieve duplicate records from a table.
SELECT [Emp_ID]
FROM [dbo].[EmployeePosition]
GROUP BY [Emp_ID]
HAVING COUNT(*)>1;


SELECT *
FROM [dbo].[EmployeePosition]
inner join(
     SELECT Emp_ID
	 from [dbo].[EmployeePosition]
	 group by Emp_ID
	 having COUNT(*)>1
)AS DuplicateEmployeeIDs
on[dbo].[EmployeePosition] .Emp_ID = DuplicateEmployeeIDs.Emp_ID;

--Q23. Write a query to retrieve the list of employees working in the same department.
SELECT E1.*
FROM Employeeinfo  AS E1
WHERE E1.Department IN (
    SELECT E2.Department
    FROM Employeeinfo  AS E2
    WHERE E1.[Emp_ID]!= E2.[Emp_ID]
);

--Q24. Write a query to retrieve the last 3 records from the EmployeeInfo table.
SELECT TOP 3*
FROM [dbo].[Employeeinfo]
ORDER BY [Emp_Id] DESC;      /*(BY DEFAULT OVER OVERALL DATA IS SORTED IN ASSECENDING SO WE WANT LAST 3 THREE
                           THERFORE WE SORT THE DATA IN DESC TO EXTRACT THE LAST 3 ROWS BY USING TOP KEYWORD)*/

--Q25. Write a query to find the third-highest salary from the EmpPosition table.
SELECT TOP 1[Salary]
FROM (
     SELECT TOP 3 [Salary]
	 FROM [dbo].[EmployeePosition]
	 ORDER BY [Salary] DESC
) AS SUBQUERY
ORDER BY [Salary] ASC

-- 3RD LOWEST SALARY
SELECT TOP 1 [Salary]
FROM(
    SELECT TOP 3 [Salary]
	FROM [dbo].[EmployeePosition]
	ORDER BY [Salary] ASC
)AS SUBQUERY
ORDER BY [Salary] DESC

--Q26. Write a query to display the first and the last record from the EmployeeInfo table.
SELECT TOP 1*
FROM [dbo].[Employeeinfo]
ORDER BY [Emp_Id] ASC
SELECT TOP 1*
FROM [dbo].[Employeeinfo]
ORDER BY [Emp_Id]DESC



--Q27. Write a query to add email validation to your database



--Q28. Write a query to retrieve Departments who have less than 2 employees working in it.
SELECT DEPARTMENT, COUNT(*) AS EMPLOYEES_WORKING
FROM [dbo].[Employeeinfo]
GROUP BY [Department]
HAVING COUNT(*) <2;

--Q29. Write a query to retrieve EmpPostion along with total salaries paid for each of them
SELECT [Emp_Position],[Salary]
FROM [dbo].[EmployeePosition]

--Q30. Write a query to fetch 50% records from the EmployeeInfo table.

SELECT TOP 50 PERCENT*
FROM [dbo].[Employeeinfo]


