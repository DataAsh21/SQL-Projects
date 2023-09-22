Create database Hospital_Database;
use [Hospital_Database];
---Create table Physician 
CREATE TABLE Physician (
  EmployeeID INT PRIMARY KEY NOT NULL,
  Name NVARCHAR(MAX) NOT NULL,
  Position NVARCHAR(MAX) NOT NULL,
  SSN INT NOT NULL
); 
---Create table Department 
CREATE TABLE Department (
  DepartmentID INT PRIMARY KEY NOT NULL,
  Name NVARCHAR(MAX) NOT NULL,
  Head INT NOT NULL,
  CONSTRAINT fk_Physician_EmployeeID FOREIGN KEY (Head) REFERENCES Physician(EmployeeID)
);
---Create table Affiliated_With
CREATE TABLE Affiliated_With (
  Physician INT NOT NULL,
  Department INT NOT NULL,
  PrimaryAffiliation BIT NOT NULL,
  PRIMARY KEY (Physician, Department),
  CONSTRAINT fk_Physician_Affiliated_With FOREIGN KEY (Physician) REFERENCES Physician(EmployeeID),
  CONSTRAINT fk_Department_DepartmentID FOREIGN KEY (Department) REFERENCES Department(DepartmentID)
);

CREATE TABLE Procedures (
  Code INT PRIMARY KEY NOT NULL,
  Name NVARCHAR(MAX) NOT NULL,
  Cost REAL NOT NULL
);
---Create table Trained_In
CREATE TABLE Trained_In (
  Physician INT NOT NULL,
  Treatment INT NOT NULL,
  CertificationDate DATETIME NOT NULL,
  CertificationExpires DATETIME NOT NULL,
  PRIMARY KEY (Physician, Treatment),
  CONSTRAINT fk_Physician_EmployeeID_Trained_In FOREIGN KEY (Physician) REFERENCES Physician(EmployeeID),
  CONSTRAINT fk_Procedure_Code FOREIGN KEY (Treatment) REFERENCES Procedures(Code)
);
---Create table Patient
CREATE TABLE Patient (
  SSN INT PRIMARY KEY NOT NULL,
  Name NVARCHAR(MAX) NOT NULL,
  Address NVARCHAR(MAX) NOT NULL,
  Phone NVARCHAR(MAX) NOT NULL,
  InsuranceID INT NOT NULL,
  PCP INT NOT NULL,
  CONSTRAINT fk_Physician_EmployeeID_Patient FOREIGN KEY (PCP) REFERENCES Physician(EmployeeID)
);
---Create table Nurse
CREATE TABLE Nurse (
  EmployeeID INT PRIMARY KEY NOT NULL,
  Name NVARCHAR(MAX) NOT NULL,
  Position NVARCHAR(MAX) NOT NULL,
  Registered BIT NOT NULL,
  SSN INT NOT NULL
);
---Create table Appointment
CREATE TABLE Appointment (
  AppointmentID INT PRIMARY KEY NOT NULL,
  Patient INT NOT NULL,
  PrepNurse INT,
  Physician INT NOT NULL,
  Start DATETIME NOT NULL,
  Ends DATETIME NOT NULL,
  ExaminationRoom NVARCHAR(MAX) NOT NULL,
  CONSTRAINT fk_Patient_SSN FOREIGN KEY (Patient) REFERENCES Patient(SSN),
  CONSTRAINT fk_Nurse_EmployeeID FOREIGN KEY (PrepNurse) REFERENCES Nurse(EmployeeID),
  CONSTRAINT fk_Physician_EmployeeID_Appointment FOREIGN KEY (Physician) REFERENCES Physician(EmployeeID)
);
---Create table Medication 
CREATE TABLE Medication (
  Code INT PRIMARY KEY NOT NULL,
  Name NVARCHAR(MAX) NOT NULL,
  Brand NVARCHAR(MAX) NOT NULL,
  Description NVARCHAR(MAX) NOT NULL
);
---Create table Prescribes 
CREATE TABLE Prescribes (
  Physician INT NOT NULL,
  Patient INT NOT NULL,
  Medication INT NOT NULL,
  Date DATETIME NOT NULL,
  Appointment INT,
  Dose NVARCHAR(MAX) NOT NULL,
  PRIMARY KEY (Physician, Patient, Medication, Date),
  CONSTRAINT fk_Physician_EmployeeID_Prescribes FOREIGN KEY (Physician) REFERENCES Physician(EmployeeID),
  CONSTRAINT fk_Patient_SSN_Prescribes FOREIGN KEY (Patient) REFERENCES Patient(SSN),
  CONSTRAINT fk_Medication_Code FOREIGN KEY (Medication) REFERENCES Medication(Code),
  CONSTRAINT fk_Appointment_AppointmentID FOREIGN KEY (Appointment) REFERENCES Appointment(AppointmentID)
);
---Create table Block
CREATE TABLE Block (
  Floor INT NOT NULL,
  Code INT NOT NULL,
  PRIMARY KEY (Floor, Code)
); 
---Create table Room
CREATE TABLE Room (
  Number INT PRIMARY KEY NOT NULL,
  Type NVARCHAR(MAX) NOT NULL,
  BlockFloor INT NOT NULL,
  BlockCode INT NOT NULL,
  Unavailable BIT NOT NULL,
  FOREIGN KEY (BlockFloor, BlockCode) REFERENCES Block(Floor, Code)
);
---Create table On_Call
CREATE TABLE On_Call (
  Nurse INT NOT NULL,
  BlockFloor INT NOT NULL,
  BlockCode INT NOT NULL,
  Start DATETIME NOT NULL,
  Ends DATETIME NOT NULL,
  PRIMARY KEY (Nurse, BlockFloor, BlockCode, Start, Ends),
  FOREIGN KEY (Nurse) REFERENCES Nurse(EmployeeID),
  FOREIGN KEY (BlockFloor, BlockCode) REFERENCES Block(Floor, Code)
);
---Create table Stay
CREATE TABLE Stay (
  StayID INT PRIMARY KEY NOT NULL,
  Patient INT NOT NULL,
  Room INT NOT NULL,
  Start DATETIME NOT NULL,
  Ends DATETIME NOT NULL,
  CONSTRAINT fk_Patient_SSN_stay FOREIGN KEY (Patient) REFERENCES Patient(SSN),
  CONSTRAINT fk_Room_Number FOREIGN KEY (Room) REFERENCES Room(Number)
);
---Create table Undergoes
CREATE TABLE Undergoes (
  Patient INT NOT NULL,
  Procedures INT NOT NULL,
  Stay INT NOT NULL,
  Date DATETIME NOT NULL,
  Physician INT NOT NULL,
  AssistingNurse INT,
  PRIMARY KEY (Patient, Procedures, Stay, Date),
  CONSTRAINT fk_Patient_SSN_Undergoes FOREIGN KEY (Patient) REFERENCES Patient(SSN),
  CONSTRAINT fk_Procedure_Code_Undergoes FOREIGN KEY (Procedures) REFERENCES Procedures(Code),
  CONSTRAINT fk_Stay_StayID FOREIGN KEY (Stay) REFERENCES Stay(StayID),
  CONSTRAINT fk_Physician_EmployeeID_Undergoes FOREIGN KEY (Physician) REFERENCES Physician(EmployeeID),
  CONSTRAINT fk_Nurse_EmployeeID_Undergoes FOREIGN KEY (AssistingNurse) REFERENCES Nurse(EmployeeID)
);

--- Inserting records in Physician table
INSERT INTO Physician VALUES(1,'John Dorian','Staff Internist',111111111);
INSERT INTO Physician VALUES(2,'Elliot Reid','Attending Physician',222222222);
INSERT INTO Physician VALUES(3,'Christopher Turk','Surgical Attending Physician',333333333);
INSERT INTO Physician VALUES(4,'Percival Cox','Senior Attending Physician',444444444);
INSERT INTO Physician VALUES(5,'Bob Kelso','Head Chief of Medicine',555555555);
INSERT INTO Physician VALUES(6,'Todd Quinlan','Surgical Attending Physician',666666666);
INSERT INTO Physician VALUES(7,'John Wen','Surgical Attending Physician',777777777);
INSERT INTO Physician VALUES(8,'Keith Dudemeister','MD Resident',888888888);
INSERT INTO Physician VALUES(9,'Molly Clock','Attending Psychiatrist',999999999);

--- Inserting records in Department table
INSERT INTO Department VALUES(1,'General Medicine',4);
INSERT INTO Department VALUES(2,'Surgery',7);
INSERT INTO Department VALUES(3,'Psychiatry',9);

--- Inserting records in Affiliated_With table
INSERT INTO Affiliated_With VALUES(1,1,1);
INSERT INTO Affiliated_With VALUES(2,1,1);
INSERT INTO Affiliated_With VALUES(3,1,0);
INSERT INTO Affiliated_With VALUES(3,2,1);
INSERT INTO Affiliated_With VALUES(4,1,1);
INSERT INTO Affiliated_With VALUES(5,1,1);
INSERT INTO Affiliated_With VALUES(6,2,1);
INSERT INTO Affiliated_With VALUES(7,1,0);
INSERT INTO Affiliated_With VALUES(7,2,1);
INSERT INTO Affiliated_With VALUES(8,1,1);
INSERT INTO Affiliated_With VALUES(9,3,1);

--- Inserting records in Procedures table
INSERT INTO Procedures VALUES(1,'Reverse Rhinopodoplasty',1500.0);
INSERT INTO Procedures VALUES(2,'Obtuse Pyloric Recombobulation',3750.0);
INSERT INTO Procedures VALUES(3,'Folded Demiophtalmectomy',4500.0);
INSERT INTO Procedures VALUES(4,'Complete Walletectomy',10000.0);
INSERT INTO Procedures VALUES(5,'Obfuscated Dermogastrotomy',4899.0);
INSERT INTO Procedures VALUES(6,'Reversible Pancreomyoplasty',5600.0);
INSERT INTO Procedures VALUES(7,'Follicular Demiectomy',25.0);

--- Inserting records in Patient table
INSERT INTO Patient VALUES(100000001,'John Smith','42 Foobar Lane','555-0256',68476213,1);
INSERT INTO Patient VALUES(100000002,'Grace Ritchie','37 Snafu Drive','555-0512',36546321,2);
INSERT INTO Patient VALUES(100000003,'Random J. Patient','101 Omgbbq Street','555-1204',65465421,2);
INSERT INTO Patient VALUES(100000004,'Dennis Doe','1100 Foobaz Avenue','555-2048',68421879,3);


--- Inserting records in Nurse table
INSERT INTO Nurse VALUES(101,'Carla Espinosa','Head Nurse',1,111111110);
INSERT INTO Nurse VALUES(102,'Laverne Roberts','Nurse',1,222222220);
INSERT INTO Nurse VALUES(103,'Paul Flowers','Nurse',0,333333330);

--- Inserting records in Appointment  table
INSERT INTO Appointment VALUES(13216584,100000001,101,1,'2008-04-24 10:00','2008-04-24 11:00','A');
INSERT INTO Appointment VALUES(26548913,100000002,101,2,'2008-04-24 10:00','2008-04-24 11:00','B');
INSERT INTO Appointment VALUES(36549879,100000001,102,1,'2008-04-25 10:00','2008-04-25 11:00','A');
INSERT INTO Appointment VALUES(46846589,100000004,103,4,'2008-04-25 10:00','2008-04-25 11:00','B');
INSERT INTO Appointment VALUES(59871321,100000004,NULL,4,'2008-04-26 10:00','2008-04-26 11:00','C');
INSERT INTO Appointment VALUES(69879231,100000003,103,2,'2008-04-26 11:00','2008-04-26 12:00','C');
INSERT INTO Appointment VALUES(76983231,100000001,NULL,3,'2008-04-26 12:00','2008-04-26 13:00','C');
INSERT INTO Appointment VALUES(86213939,100000004,102,9,'2008-04-27 10:00','2008-04-21 11:00','A');
INSERT INTO Appointment VALUES(93216548,100000002,101,2,'2008-04-27 10:00','2008-04-27 11:00','B');

--- Inserting records in Medication table
INSERT INTO Medication VALUES(1,'Procrastin-X','X','N/A');
INSERT INTO Medication VALUES(2,'Thesisin','Foo Labs','N/A');
INSERT INTO Medication VALUES(3,'Awakin','Bar Laboratories','N/A');
INSERT INTO Medication VALUES(4,'Crescavitin','Baz Industries','N/A');
INSERT INTO Medication VALUES(5,'Melioraurin','Snafu Pharmaceuticals','N/A');

--- Inserting records in Prescribes table
INSERT INTO Prescribes VALUES(1,100000001,1,'2008-04-24 10:47',13216584,'5');
INSERT INTO Prescribes VALUES(9,100000004,2,'2008-04-27 10:53',86213939,'10');
INSERT INTO Prescribes VALUES(9,100000004,2,'2008-04-30 16:53',NULL,'5');

--- Inserting records in Block table
INSERT INTO Block VALUES(1,1);
INSERT INTO Block VALUES(1,2);
INSERT INTO Block VALUES(1,3);
INSERT INTO Block VALUES(2,1);
INSERT INTO Block VALUES(2,2);
INSERT INTO Block VALUES(2,3);
INSERT INTO Block VALUES(3,1);
INSERT INTO Block VALUES(3,2);
INSERT INTO Block VALUES(3,3);
INSERT INTO Block VALUES(4,1);
INSERT INTO Block VALUES(4,2);
INSERT INTO Block VALUES(4,3);

--- Inserting records in Room table
INSERT INTO Room VALUES(101,'Single',1,1,0);
INSERT INTO Room VALUES(102,'Single',1,1,0);
INSERT INTO Room VALUES(103,'Single',1,1,0);
INSERT INTO Room VALUES(111,'Single',1,2,0);
INSERT INTO Room VALUES(112,'Single',1,2,1);
INSERT INTO Room VALUES(113,'Single',1,2,0);
INSERT INTO Room VALUES(121,'Single',1,3,0);
INSERT INTO Room VALUES(122,'Single',1,3,0);
INSERT INTO Room VALUES(123,'Single',1,3,0);
INSERT INTO Room VALUES(201,'Single',2,1,1);
INSERT INTO Room VALUES(202,'Single',2,1,0);
INSERT INTO Room VALUES(203,'Single',2,1,0);
INSERT INTO Room VALUES(211,'Single',2,2,0);
INSERT INTO Room VALUES(212,'Single',2,2,0);
INSERT INTO Room VALUES(213,'Single',2,2,1);
INSERT INTO Room VALUES(221,'Single',2,3,0);
INSERT INTO Room VALUES(222,'Single',2,3,0);
INSERT INTO Room VALUES(223,'Single',2,3,0);
INSERT INTO Room VALUES(301,'Single',3,1,0);
INSERT INTO Room VALUES(302,'Single',3,1,1);
INSERT INTO Room VALUES(303,'Single',3,1,0);
INSERT INTO Room VALUES(311,'Single',3,2,0);
INSERT INTO Room VALUES(312,'Single',3,2,0);
INSERT INTO Room VALUES(313,'Single',3,2,0);
INSERT INTO Room VALUES(321,'Single',3,3,1);
INSERT INTO Room VALUES(322,'Single',3,3,0);
INSERT INTO Room VALUES(323,'Single',3,3,0);
INSERT INTO Room VALUES(401,'Single',4,1,0);
INSERT INTO Room VALUES(402,'Single',4,1,1);
INSERT INTO Room VALUES(403,'Single',4,1,0);
INSERT INTO Room VALUES(411,'Single',4,2,0);
INSERT INTO Room VALUES(412,'Single',4,2,0);
INSERT INTO Room VALUES(413,'Single',4,2,0);
INSERT INTO Room VALUES(421,'Single',4,3,1);
INSERT INTO Room VALUES(422,'Single',4,3,0);
INSERT INTO Room VALUES(423,'Single',4,3,0);

--- Inserting records in On_Call table
INSERT INTO On_Call VALUES(101,1,1,'2008-11-04 11:00','2008-11-04 19:00');
INSERT INTO On_Call VALUES(101,1,2,'2008-11-04 11:00','2008-11-04 19:00');
INSERT INTO On_Call VALUES(102,1,3,'2008-11-04 11:00','2008-11-04 19:00');
INSERT INTO On_Call VALUES(103,1,1,'2008-11-04 19:00','2008-11-05 03:00');
INSERT INTO On_Call VALUES(103,1,2,'2008-11-04 19:00','2008-11-05 03:00');
INSERT INTO On_Call VALUES(103,1,3,'2008-11-04 19:00','2008-11-05 03:00');

--- Inserting records in Stay table
INSERT INTO Stay VALUES(3215,100000001,111,'2008-05-01','2008-05-04');
INSERT INTO Stay VALUES(3216,100000003,123,'2008-05-03','2008-05-14');
INSERT INTO Stay VALUES(3217,100000004,112,'2008-05-02','2008-05-03');

--- Inserting records in Undergoes table
INSERT INTO Undergoes VALUES(100000001,6,3215,'2008-05-02',3,101);
INSERT INTO Undergoes VALUES(100000001,2,3215,'2008-05-03',7,101);
INSERT INTO Undergoes VALUES(100000004,1,3217,'2008-05-07',3,102);
INSERT INTO Undergoes VALUES(100000004,5,3217,'2008-05-09',6,NULL);
INSERT INTO Undergoes VALUES(100000001,7,3217,'2008-05-10',7,101);
INSERT INTO Undergoes VALUES(100000004,4,3217,'2008-05-13',3,103);

--- Inserting records in Trained_In table
INSERT INTO Trained_In VALUES(3,1,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(3,2,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(3,5,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(3,6,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(3,7,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(6,2,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(6,5,'2007-01-01','2007-12-31');
INSERT INTO Trained_In VALUES(6,6,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(7,1,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(7,2,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(7,3,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(7,4,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(7,5,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(7,6,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(7,7,'2008-01-01','2008-12-31');


--1. From the following table, write a SQL query to find out which nurses have not yet been registered. Return all the fields of nurse table.
select*
from Nurse
where Registered = 'false';

/*2. From the following table, write a SQL query to identify the nurses in charge of each department. 
Return nursename as “name”, Position as “Position”.*/
select [Name] as name , [Position] as [Position]
from [dbo].[Nurse]
where [Position] = 'Head Nurse'

/*3. From the following tables, write a SQL query to identify the physicians who are the department heads. 
Return Department name as “Department” and Physician name as “Physician”.*/
select [dbo].[Physician].[Name] as Physician ,[dbo].[Department].[Name] as Department
from [dbo].[Physician]
join [dbo].[Department] on [dbo].[Physician].EmployeeID = [dbo].[Department].Head

/*4. From the following table, write a SQL query to count the number of patients who scheduled an appointment with at least one physician.
Return count as "Number of patients taken at least one appointment".*/
select count(distinct([Patient]))as no_of_patient
from [dbo].[Appointment]

/*5. From the following table, write a SQL query to locate the floor and block where room number 212 is located.
Return block floor as "Floor" and block code as "Block".*/

select [BlockFloor] as floors , [BlockCode] as block
from [dbo].[Room]
where [Number] = 212;

/*6. From the following table, write a SQL query to count the number available rooms. Return count as "Number of available rooms".*/
select count([Number]) as avilable_rooms
from [dbo].[Room]
where [Unavailable] = 'false';


/*7. From the following table, write a SQL query to count the number of unavailable rooms. Return count as "Number of unavailable rooms".*/
select count([Number]) as avilable_rooms
from [dbo].[Room]
where [Unavailable] = 'true';

/*8. From the following tables, write a SQL query to identify the physician and the department with which he or she is affiliated.
Return Physician name as "Physician", and department name as "Department".*/
SELECT [dbo].[Physician].[Name] AS Physician, [dbo].[Department].[Name] AS Department
FROM [dbo].[Department]
JOIN [dbo].[Affiliated_With] ON [dbo].[Department].[DepartmentID] = [dbo].[Affiliated_With].[Department]
join  [dbo].[Physician]  on   [dbo].[Affiliated_With].[Physician] =    [dbo].[Physician].EmployeeID    

/*9. From the following tables, write a SQL query to find those physicians who have received special training. 
Return Physician name as “Physician”, treatment procedure name as "Treatment".*/
select [dbo].[Physician].Name as Physician, [dbo].[Procedures].Name
from [dbo].[Procedures]
join [dbo].[Trained_In] on [dbo].[Procedures].Code =[dbo].[Trained_In].Treatment
join [dbo].[Physician] on [dbo].[Trained_In].Physician = [dbo].[Physician].EmployeeID

/*10. From the following tables, write a SQL query to find those physicians who are yet to be affiliated.
Return Physician name as "Physician", Position, and department as "Department".*/
select [dbo].[Physician].Name as Physician, [dbo].[Physician].Position as position , [dbo].[Department].Name as Department
from [dbo].[Department]
join [dbo].[Affiliated_With] on [dbo].[Department].DepartmentID = [dbo].[Affiliated_With].[Department]
join [dbo].[Physician] on [dbo].[Affiliated_With].[Physician] = [dbo].[Physician].EmployeeID
where [dbo].[Affiliated_With].[PrimaryAffiliation] = 'false'


/*11. From the following tables, write a SQL query to identify physicians who are not specialists. 
Return Physician name as "Physician", position as "Designation".*/
select [dbo].[Physician].Name as Physician, [dbo].[Physician].Position as Designation
from [dbo].[Physician]
left join [dbo].[Trained_In] on [dbo].[Physician].EmployeeID = [dbo].[Trained_In].Physician
where [dbo].[Trained_In].Treatment is null;

/*12. From the following tables, write a SQL query to find the patients with their physicians by whom they received preliminary treatment.
Return Patient name as "Patient", address as "Address" and Physician name as "Physician".*/
select [dbo].[Patient].Name as Patient, [dbo].[Patient].Address as Address, [dbo].[Physician].Name
from [dbo].[Patient]
join [dbo].[Physician] on [dbo].[Patient].PCP = [dbo].[Physician].EmployeeID

/*13. From the following tables, write a SQL query to identify the patients and the number of physicians with whom they have scheduled appointments. 
Return Patient name as "Patient", number of Physicians as "Appointment for No. of Physicians".*/
select [dbo].[Patient].Name as Patient, count([dbo].[Appointment].[AppointmentID]) as Appointment_for_No_of_Physicians
from [dbo].[Patient]
join [dbo].[Appointment] on [dbo].[Patient].SSN = [dbo].[Appointment].Patient
group by [dbo].[Patient].Name

/*14. From the following tables, write a SQL query to count the number of unique patients who have been scheduled for examination room 'C'. 
Return unique patients as "No. of patients got appointment for room C".*/
select count(distinct([Patient])) as unique_patients
from [dbo].[Appointment]
where [ExaminationRoom]= 'c'

/*15. From the following tables, write a SQL query to find the names of the patients and the room number where they need to be treated.
Return patient name as "Patient", examination room as "Room No.", and starting date time as Date "Date and Time of appointment".*/
select [dbo].[Patient].Name as Patient, [dbo].[Appointment].ExaminationRoom as Room_No, [dbo].[Appointment].Start as "Date and Time of appointment"
from [dbo].[Patient]
join [dbo].[Appointment] on [dbo].[Patient].SSN = [dbo].[Appointment].Patient;

/*16. From the following tables, write a SQL query to identify the nurses and the room in which they will assist the physicians.
Return Nurse Name as "Name of the Nurse" and examination room as "Room No."*/
select [dbo].[Nurse].Name as "Name of the Nurse",[dbo].[Appointment].ExaminationRoom as "Room No."
from [dbo].[Nurse]
join  [dbo].[Appointment] on [dbo].[Nurse].EmployeeID = [dbo].[Appointment].PrepNurse


/*17. From the following tables, write a SQL query to locate the patients who attended the appointment on the 25th of April at 10 a.m. 
Return Name of the patient, Name of the Nurse assisting the physician, Physician Name as "Name of the physician", examination room as "Room No.",
schedule date and approximate time to meet the physician.*/

select [dbo].[Patient].Name as "Name of the patient",[dbo].[Nurse].Name as "Name of the Nurse",[dbo].[Physician].Name as "Name of the physician",
[dbo].[Appointment].ExaminationRoom as "Room No.",[dbo].[Appointment].Start
from [dbo].[Patient]
join [dbo].[Appointment] on [dbo].[Patient].SSN = [dbo].[Appointment].Patient
join [dbo].[Nurse] on [dbo].[Appointment].PrepNurse = [dbo].[Nurse].EmployeeID
join [dbo].[Physician] on [dbo].[Appointment].Physician = [dbo].[Physician].EmployeeID
WHERE [Start]='2008-04-25 10:00:00';

/*18. From the following tables, write a SQL query to identify those patients and their physicians who do not require any nursing assistance. 
Return Name of the patient as "Name of the patient", Name of the Physician as "Name of the physician" and examination room as  "Room No.".*/

select [dbo].[Patient].Name as  "Name of the patient", [dbo].[Physician].Name as "Name of the physician" , [dbo].[Appointment].ExaminationRoom as  "Room No."
from [dbo].[Patient]
join [dbo].[Appointment] on [dbo].[Patient].SSN = [dbo].[Appointment].Patient
join [dbo].[Physician] on [dbo].[Appointment].Physician = [dbo].[Physician].EmployeeID
where [dbo].[Appointment].PrepNurse is   null

select* from [dbo].[Nurse]
select*from [dbo].[Patient]
select*from [dbo].[Appointment]
select*from [dbo].[Physician]

/*19. From the following tables, write a SQL query to locate the patients' treating physicians and medications.
Return Patient name as "Patient", Physician name as "Physician", Medication name as "Medication".*/
select [dbo].[Patient].Name as "Patient",
       [dbo].[Physician].Name as "Physician",
       [dbo].[Medication].Name as "Physician"
from [dbo].[Patient]
join [dbo].[Prescribes] on [dbo].[Patient].SSN = [dbo].[Prescribes].Patient
join [dbo].[Physician] on [dbo].[Prescribes].Physician = [dbo].[Physician].EmployeeID
join [dbo].[Medication] on [dbo].[Prescribes].Medication = [dbo].[Medication].Code

/*20. From the following tables, write a SQL query to identify patients who have made an advanced appointment.
Return Patient name as "Patient", Physician name as "Physician" and Medication name as "Medication".*/
select [dbo].[Patient].Name as "Patient",
       [dbo].[Physician].Name as "Physician",
       [dbo].[Medication].Name as "Physician"
from [dbo].[Patient]
join [dbo].[Prescribes] on [dbo].[Patient].SSN = [dbo].[Prescribes].Patient
join [dbo].[Physician] on [dbo].[Prescribes].Physician = [dbo].[Physician].EmployeeID
join [dbo].[Medication] on [dbo].[Prescribes].Medication = [dbo].[Medication].Code
where [dbo].[Prescribes].Appointment is not null;

select*from [dbo].[Prescribes]

/*21. From the following tables, write a SQL query to find those patients who did not schedule an appointment.
Return Patient name as "Patient", Physician name as "Physician" and Medication name as "Medication".*/

select [dbo].[Patient].Name as "Patient",
       [dbo].[Physician].Name as "Physician",
       [dbo].[Medication].Name as "Physician"
from [dbo].[Patient]
join [dbo].[Prescribes] on [dbo].[Patient].SSN = [dbo].[Prescribes].Patient
join [dbo].[Physician] on [dbo].[Prescribes].Physician = [dbo].[Physician].EmployeeID
join [dbo].[Medication] on [dbo].[Prescribes].Medication = [dbo].[Medication].Code
where [dbo].[Prescribes].Appointment is  null;

/*22. From the following table, write a SQL query to count the number of available rooms in each block. 
Sort the result-set on ID of the block. Return ID of the block as "Block", count number of available rooms as "Number of available rooms".*/
SELECT COUNT(*) AS  "Number of available rooms",[BlockCode]
FROM [dbo].[Room]
WHERE [Unavailable] = 'FALSE'
GROUP BY [BlockCode]
ORDER BY [BlockCode]

/*23. From the following table, write a SQL query to count the number of available rooms in each floor. Sort the result-set on block floor.
Return floor ID as "Floor" and count the number of available rooms as "Number of available rooms".*/
SELECT COUNT(*) AS  "Number of available rooms",[BlockFloor]
FROM [dbo].[Room]
WHERE [Unavailable] = 'FALSE'
GROUP BY [BlockFloor]
ORDER BY [BlockFloor]

/*24. From the following table, write a SQL query to count the number of available rooms for each floor in each block. 
Sort the result-set on floor ID, ID of the block. Return the floor ID as "Floor", ID of the block as "Block",
and number of available rooms as "Number of available rooms".*/
SELECT COUNT(*) AS "Number of available rooms", [BlockFloor] AS "Floor", [BlockCode] AS "Block"
FROM [dbo].[Room]
WHERE [Unavailable] = 'FALSE'
GROUP BY [BlockFloor],[BlockCode]
ORDER BY [BlockFloor],[BlockCode]

/*25. From the following tables, write a SQL query to count the number of rooms that are unavailable in each block and on each floor.
Sort the result-set on block floor, block code. Return the floor ID as "Floor", block ID as "Block", 
and number of unavailable as “Number of unavailable rooms".*/
SELECT COUNT(*) AS "Number of available rooms", [BlockFloor] AS "Floor", [BlockCode] AS "Block"
FROM [dbo].[Room]
WHERE [Unavailable] = 'TRUE'
GROUP BY [BlockFloor],[BlockCode]
ORDER BY [BlockFloor],[BlockCode]

/*26. From the following tables, 
write a SQL query to find the floor where the maximum number of rooms are available. 
Return floor ID as "Floor", count "Number of available rooms".*/

SELECT TOP 1 COUNT(*) AS  "Number of available rooms",[BlockFloor]
FROM [dbo].[Room]
WHERE [Unavailable] = 'FALSE'
GROUP BY [BlockFloor]
ORDER BY [BlockFloor] 

/*27. From the following tables,
write a SQL query to locate the floor with the minimum number of available rooms.
Return floor ID as "Floor", Number of available rooms.*/
SELECT
COUNT(*) AS "Number of available rooms",
[BlockFloor]
FROM [dbo].[Room]
WHERE [Unavailable] = 'FALSE'
GROUP BY [BlockFloor]
HAVING COUNT(*) < (
  SELECT TOP 1 COUNT(*) AS "Number of available rooms"
  FROM [dbo].[Room]
  WHERE [Unavailable] = 'FALSE'
  GROUP BY [BlockFloor]
  ORDER BY COUNT(*) DESC
)
ORDER BY "Number of available rooms" ASC;

/*28. From the following tables, write a SQL query to find the name of the patients, their block, floor, and room number where they admitted.*/
SELECT [dbo].[Patient].Name AS NAME,[dbo].[Room].BlockFloor AS FLOOR, [dbo].[Room].BlockCode AS CODE, [dbo].[Stay].[Room] AS ROOM
FROM [dbo].[Stay]
JOIN [dbo].[Patient] ON [dbo].[Stay].[Patient] = [dbo].[Patient].[SSN]
JOIN [dbo].[Room] ON [dbo].[Stay].[Room] = [dbo].[Room].[Number]

/*29. From the following tables, write a SQL query to locate the nurses and the block where they are scheduled to attend the on-call patients.
Return Nurse Name as "Nurse", Block code as "Block".*/
select [dbo].[Nurse].Name as "Nurse",[dbo].[On_Call].BlockCode as "Block"
from [dbo].[Nurse]
join [dbo].[On_Call] on [dbo].[Nurse].EmployeeID = [dbo].[On_Call].Nurse

/*30. From the following tables, write a SQL query to get
a) name of the patient,
b) name of the physician who is treating him or her,
c) name of the nurse who is attending him or her,
d) which treatement is going on to the patient,
e) the date of release,
f) in which room the patient has admitted and which floor and block the room belongs to respectively.*/

select [dbo].[Patient].[Name] as patient,[dbo].[Physician].Name as physician,[dbo].[Nurse].Name as nurse,[dbo].[Stay].Ends as "date of release",
[dbo].[Room].[Number],[dbo].[Room].[BlockFloor],[dbo].[Room].[BlockCode]
from [dbo].[Undergoes]
join [dbo].[Patient] on [dbo].[Undergoes].[Patient] =[dbo].[Patient].SSN
join[dbo].[Physician] on [dbo].[Undergoes].Physician = [dbo].[Physician].EmployeeID
left join[dbo].[Nurse] on [dbo].[Undergoes].[AssistingNurse] = [dbo].[Nurse].EmployeeID
join [dbo].[Stay] on [dbo].[Undergoes].Stay = [dbo].[Stay].StayID
join [dbo].[Room] on [dbo].[Stay].Room = [dbo].[Room].Number

/*31. From the following tables, write a SQL query to find all physicians who have performed a medical procedure but are not certified to do so. 
Return Physician name as "Physician".*/

SELECT p.name AS "Physician"
FROM physician p
JOIN undergoes u ON p.employeeid = u.physician
 left JOIN trained_in t ON u.physician = t.physician AND u.Procedures = t.treatment
WHERE t.treatment IS NULL;


/*32. From the following tables, write a SQL query to find all physicians, their procedures, 
the date when the procedure was performed, and the name of the patient on whom the procedure was performed, 
but the physicians are not certified to perform that procedure.
Return Physician Name as "Physician", Procedure Name as "Procedure", date, and Patient. Name as "Patient".*/
select [dbo].[Physician].Name,[dbo].[Procedures].Name,[dbo].[Undergoes].Date,[dbo].[Patient].Name
from [dbo].[Physician]
join [dbo].[Undergoes] on [dbo].[Physician].EmployeeID = [dbo].[Undergoes].Physician
join [dbo].[Patient] on [dbo].[Undergoes].Patient = [dbo].[Patient].SSN
join[dbo].[Procedures] on [dbo].[Undergoes].Procedures = [dbo].[Procedures].Code
left join[dbo].[Trained_In] on [dbo].[Procedures].Code = [dbo].[Trained_In].Treatment
and [dbo].[Trained_In].Physician = [dbo].[Physician].EmployeeID
WHERE [dbo].[Trained_In].Treatment IS NULL;

select*from [dbo].[Trained_In]
where Treatment IS NULL;
select* from [dbo].[Procedures]
select *from [dbo].[Physician]
select *from [dbo].[Patient]

/*33. From the following table, write a SQL query to find all physicians who completed a medical procedure with certification after the expiration date of their license.
Return Physician Name as "Physician", Position as "Position".*/
select  [dbo].[Physician].Name as "Physician", [dbo].[Physician].Position as "Position"
from [dbo].[Physician]
join [dbo].[Undergoes] on [dbo].[Physician].EmployeeID = [dbo].[Undergoes].Physician
join [dbo].[Trained_In] on [dbo].[Undergoes].Physician = [dbo].[Trained_In].Physician
and [dbo].[Undergoes].Procedures = [dbo].[Trained_In].Treatment
where [dbo].[Undergoes].Date > [dbo].[Trained_In].CertificationExpires;

/*34. From the following table, write a SQL query to find all physicians who have completed medical procedures 
with certification after their certificates expired. Return Physician Name as "Physician",
Position as" Position", Procedure Name as "Procedure", Date of Procedure as "Date of Procedure", Patient Name as "Patient",
and expiry date of certification as "Expiry Date of Certificate".*/

SELECT p.name AS "Physician",
       p.position AS "Position",
       pr.name AS "Procedure",
       u.date AS "Date of Procedure",
       pt.name AS "Patient",
       t.certificationexpires AS "Expiry Date of Certificate"
FROM physician p,
     undergoes u,
     patient pt,
     Procedures pr,
               trained_in t
WHERE u.patient = pt.ssn
  AND u.Procedures = pr.code
  AND u.physician = p.employeeid
  AND Pr.code = t.treatment
  AND P.employeeid = t.physician
  AND u.Date > t.certificationexpires;


/*35. From the following table, write a SQL query to find out, which nurses have been on call for room 122 in the past. Return name of the nurses.*/
select [dbo].[Nurse].Name as nurses
from [dbo].[Nurse]
join [dbo].[On_Call] on [dbo].[Nurse].EmployeeID = [dbo].[On_Call].Nurse
join [dbo].[Room] on [dbo].[On_Call].BlockCode = [dbo].[Room].BlockCode
and [dbo].[On_Call].BlockFloor = [dbo].[Room].BlockFloor
where [dbo].[Room].Number = 122;

/*36. From the following table, write a SQL query to determine which patients have been prescribed medication by their primary care physician.
Return Patient name as "Patient", and Physician Name as "Physician".*/
select [dbo].[Patient].Name as "Patient" ,[dbo].[Physician].Name as "Physician"
from [dbo].[Patient]
join [dbo].[Prescribes] on [dbo].[Patient].SSN = [dbo].[Prescribes].Patient
join [dbo].[Physician] on [dbo].[Patient].PCP = [dbo].[Physician].EmployeeID
where [dbo].[Patient].PCP = [dbo].[Prescribes].Physician
and [dbo].[Patient].PCP = [dbo].[Physician].EmployeeID

/*37. From the following table, write a SQL query to find those patients who have undergone a procedure costing more than $5,000, 
as well as the name of the physician who has provided primary care, should be identified.
Return name of the patient as "Patient", name of the physician as "Primary Physician", and cost for the procedure as "Procedure Cost".*/

SELECT pt.name AS " Patient ",
p.name AS "Primary Physician",
pd.cost AS " Procedure Cost"
FROM patient pt
JOIN undergoes u ON u.patient=pt.ssn
JOIN physician p ON pt.pcp=p.employeeid
JOIN Procedures pd ON u.Procedures=pd.code
WHERE pd.cost>5000;

/*38. From the following table, write a SQL query to find those patients with at least two appointments 
in which the nurse who prepared the appointment was a registered nurse and the physician who provided primary care should be identified.
Return Patient name as "Patient", Physician name as "Primary Physician", and Nurse Name as "Nurse".*/
SELECT pt.name AS "Patient",
       p.name AS "Primary Physician",
       n.name AS "Nurse"
FROM appointment a
JOIN patient pt ON a.patient=pt.ssn
JOIN nurse n ON a.prepnurse=n.employeeid
JOIN physician p ON pt.pcp=p.employeeid
WHERE a.patient IN
    (SELECT patient
     FROM appointment a
     GROUP BY a.patient
     HAVING count(*)>=2)
  AND n.registered='true'
ORDER BY pt.name;


/*39. From the following table, write a SQL query to identify those patients whose primary care is provided by a physician '
who is not the head of any department. Return Patient name as "Patient", Physician Name as "Primary care Physician".*/
SELECT pt.name AS "Patient",
       p.name AS "Primary care Physician"
FROM patient pt
JOIN physician p ON pt.pcp=p.employeeid
WHERE pt.pcp NOT IN
    (SELECT head
     FROM department);
