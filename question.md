# Queries With Solutions
#### 1. From the following table, write a SQL query to find out which nurses have not yet been registered. Return all the fields of nurse table.

<img width="686" alt="Screenshot 2023-09-22 142747" src="https://github.com/DataAsh21/SQL-Projects/assets/133566238/9f65ad6c-0e34-471d-96e2-6e04cee01b32">

~~~
select*
from Nurse
where Registered = 'false';
~~~

#### 2. From the following table, write a SQL query to identify the nurses in charge of each department. Return nursename as “name”, Position as “Position”.
~~~
select [Name] as name , [Position] as [Position]
from [dbo].[Nurse]
where [Position] = 'Head Nurse'
~~~

#### 3. From the following tables, write a SQL query to identify the physicians who are the department heads. Return Department name as “Department” and Physician name as “Physician”.

<img width="533" alt="Screenshot 2023-09-22 143417" src="https://github.com/DataAsh21/SQL-Projects/assets/133566238/1a7ab8be-7a06-4eba-a979-1b0bc8114291">

~~~
select [dbo].[Physician].[Name] as Physician ,[dbo].[Department].[Name] as Department
from [dbo].[Physician]
join [dbo].[Department] on [dbo].[Physician].EmployeeID = [dbo].[Department].Head
~~~

#### 4. From the following table, write a SQL query to count the number of patients who scheduled an appointment with at least one physician. Return count as "Number of patients taken at least one appointment".
<img width="690" alt="Screenshot 2023-09-22 143647" src="https://github.com/DataAsh21/SQL-Projects/assets/133566238/06d42d32-0111-410b-9c75-c29334a6401e">

~~~
select count(distinct([Patient]))as no_of_patient
from [dbo].[Appointment]
~~~

#### 5. From the following table, write a SQL query to locate the floor and block where room number 212 is located. Return block floor as "Floor" and block code as "Block".
<img width="690" alt="Screenshot 2023-09-22 143647" src="https://github.com/DataAsh21/SQL-Projects/assets/133566238/49ed8139-d353-4092-96f7-b3c8110315e6">

~~~
select [BlockFloor] as floors , [BlockCode] as block
from [dbo].[Room]
where [Number] = 212;
~~~

#### 6. From the following table, write a SQL query to count the number available rooms. Return count as "Number of available rooms".

~~~
select count([Number]) as avilable_rooms
from [dbo].[Room]
where [Unavailable] = 'false';
~~~

#### 7. From the following table, write a SQL query to count the number of unavailable rooms. Return count as "Number of unavailable rooms".

~~~
select count([Number]) as avilable_rooms
from [dbo].[Room]
where [Unavailable] = 'true';
~~~

#### 8. From the following tables, write a SQL query to identify the physician and the department with which he or she is affiliated. Return Physician name as "Physician", and department name as "Department".

<img width="541" alt="Screenshot 2023-09-22 144126" src="https://github.com/DataAsh21/SQL-Projects/assets/133566238/b46d64ae-1359-463e-b9e4-ebe31a1e5991">

~~~
SELECT [dbo].[Physician].[Name] AS Physician, [dbo].[Department].[Name] AS Department
FROM [dbo].[Department]
JOIN [dbo].[Affiliated_With] ON [dbo].[Department].[DepartmentID] = [dbo].[Affiliated_With].[Department]
join  [dbo].[Physician]  on   [dbo].[Affiliated_With].[Physician] =    [dbo].[Physician].EmployeeID
~~~

#### 9. From the following tables, write a SQL query to find those physicians who have received special training. Return Physician name as “Physician”, treatment procedure name as "Treatment".

<img width="541" alt="Screenshot 2023-09-22 144409" src="https://github.com/DataAsh21/SQL-Projects/assets/133566238/8411a1ca-7bbf-4e3b-81c0-d61ce685b0da">

~~~
select [dbo].[Physician].Name as Physician, [dbo].[Procedures].Name
from [dbo].[Procedures]
join [dbo].[Trained_In] on [dbo].[Procedures].Code =[dbo].[Trained_In].Treatment
join [dbo].[Physician] on [dbo].[Trained_In].Physician = [dbo].[Physician].EmployeeID
~~~

#### 10. From the following tables, write a SQL query to find those physicians who are yet to be affiliated. Return Physician name as "Physician", Position, and department as "Department".

<img width="543" alt="Screenshot 2023-09-22 144514" src="https://github.com/DataAsh21/SQL-Projects/assets/133566238/35b7a930-bdfa-4695-8f94-1d391e46169b">

~~~
select [dbo].[Physician].Name as Physician, [dbo].[Physician].Position as position , [dbo].[Department].Name as Department
from [dbo].[Department]
join [dbo].[Affiliated_With] on [dbo].[Department].DepartmentID = [dbo].[Affiliated_With].[Department]
join [dbo].[Physician] on [dbo].[Affiliated_With].[Physician] = [dbo].[Physician].EmployeeID
where [dbo].[Affiliated_With].[PrimaryAffiliation] = 'false'
~~~

#### 11. From the following tables, write a SQL query to identify physicians who are not specialists. Return Physician name as "Physician", position as "Designation".

<img width="539" alt="Screenshot 2023-09-22 144614" src="https://github.com/DataAsh21/SQL-Projects/assets/133566238/57363fa2-24fb-400f-b65a-6fcfce5db2ed">

~~~
select [dbo].[Physician].Name as Physician, [dbo].[Physician].Position as Designation
from [dbo].[Physician]
left join [dbo].[Trained_In] on [dbo].[Physician].EmployeeID = [dbo].[Trained_In].Physician
where [dbo].[Trained_In].Treatment is null;
~~~

#### 12. From the following tables, write a SQL query to find the patients with their physicians by whom they received preliminary treatment. Return Patient name as "Patient", address as "Address" and Physician name as "Physician".


<img width="539" alt="Screenshot 2023-09-22 144801" src="https://github.com/DataAsh21/SQL-Projects/assets/133566238/a365b984-31ba-4964-b068-25ef408503ee">

~~~
select [dbo].[Patient].Name as Patient, [dbo].[Patient].Address as Address, [dbo].[Physician].Name
from [dbo].[Patient]
join [dbo].[Physician] on [dbo].[Patient].PCP = [dbo].[Physician].EmployeeID
~~~

#### 13. From the following tables, write a SQL query to identify the patients and the number of physicians with whom they have scheduled appointments. Return Patient name as "Patient", number of Physicians as "Appointment for No. of Physicians".
<img width="539" alt="Screenshot 2023-09-22 144924" src="https://github.com/DataAsh21/SQL-Projects/assets/133566238/2bd28f8c-cc43-4750-b674-2f54385b37dd">

~~~
select [dbo].[Patient].Name as Patient, count([dbo].[Appointment].[AppointmentID]) as Appointment_for_No_of_Physicians
from [dbo].[Patient]
join [dbo].[Appointment] on [dbo].[Patient].SSN = [dbo].[Appointment].Patient
group by [dbo].[Patient].Name
~~~

#### 14. From the following tables, write a SQL query to count the number of unique patients who have been scheduled for examination room 'C'. Return unique patients as "No. of patients got appointment for room C".
~~~
select count(distinct([Patient])) as unique_patients
from [dbo].[Appointment]
where [ExaminationRoom]= 'c'
~~~

#### 15. From the following tables, write a SQL query to find the names of the patients and the room number where they need to be treated. Return patient name as "Patient", examination room as "Room No.", and starting date time as Date "Date and Time of appointment".

~~~
select [dbo].[Patient].Name as Patient, [dbo].[Appointment].ExaminationRoom as Room_No, [dbo].[Appointment].Start as "Date and Time of appointment"
from [dbo].[Patient]
join [dbo].[Appointment] on [dbo].[Patient].SSN = [dbo].[Appointment].Patient;
~~~

#### 16. From the following tables, write a SQL query to identify the nurses and the room in which they will assist the physicians. Return Nurse Name as "Name of the Nurse" and examination room as "Room No.".
<img width="539" alt="Screenshot 2023-09-22 145702" src="https://github.com/DataAsh21/SQL-Projects/assets/133566238/4ff172d5-0437-424e-8491-a094be588aee">

~~~
select [dbo].[Nurse].Name as "Name of the Nurse",[dbo].[Appointment].ExaminationRoom as "Room No."
from [dbo].[Nurse]
join  [dbo].[Appointment] on [dbo].[Nurse].EmployeeID = [dbo].[Appointment].PrepNurse
~~~

#### 17. From the following tables, write a SQL query to locate the patients who attended the appointment on the 25th of April at 10 a.m. Return Name of the patient, Name of the Nurse assisting the physician, Physician Name as "Name of the physician", examination room as "Room No.", schedule date and approximate time to meet the physician.

<img width="540" alt="Screenshot 2023-09-22 145840" src="https://github.com/DataAsh21/SQL-Projects/assets/133566238/b1827b2a-6d65-483c-b30f-8fde33b986cd">
<img width="540" alt="Screenshot 2023-09-22 145857" src="https://github.com/DataAsh21/SQL-Projects/assets/133566238/5d4baf4e-8b95-46a5-b3d2-429d47250094">

~~~
select [dbo].[Patient].Name as "Name of the patient",[dbo].[Nurse].Name as "Name of the Nurse",[dbo].[Physician].Name as "Name of the physician",
[dbo].[Appointment].ExaminationRoom as "Room No.",[dbo].[Appointment].Start
from [dbo].[Patient]
join [dbo].[Appointment] on [dbo].[Patient].SSN = [dbo].[Appointment].Patient
join [dbo].[Nurse] on [dbo].[Appointment].PrepNurse = [dbo].[Nurse].EmployeeID
join [dbo].[Physician] on [dbo].[Appointment].Physician = [dbo].[Physician].EmployeeID
WHERE [Start]='2008-04-25 10:00:00';
~~~

#### 18. From the following tables, write a SQL query to identify those patients and their physicians who do not require any nursing assistance. Return Name of the patient as "Name of the patient", Name of the Physician as "Name of the physician" and examination room as "Room No.".

<img width="541" alt="Screenshot 2023-09-22 150058" src="https://github.com/DataAsh21/SQL-Projects/assets/133566238/be615247-be56-4f48-add3-6a7f1b82260b">

~~~
select [dbo].[Patient].Name as  "Name of the patient", [dbo].[Physician].Name as "Name of the physician" , [dbo].[Appointment].ExaminationRoom as  "Room No."
from [dbo].[Patient]
join [dbo].[Appointment] on [dbo].[Patient].SSN = [dbo].[Appointment].Patient
join [dbo].[Physician] on [dbo].[Appointment].Physician = [dbo].[Physician].EmployeeID
where [dbo].[Appointment].PrepNurse is null;
~~~

#### 19. From the following tables, write a SQL query to locate the patients' treating physicians and medications. Return Patient name as "Patient", Physician name as "Physician", Medication name as "Medication".
<img width="542" alt="Screenshot 2023-09-22 150351" src="https://github.com/DataAsh21/SQL-Projects/assets/133566238/6e5f0f13-89d2-45f7-8164-144e090610e1">
<img width="543" alt="Screenshot 2023-09-22 150408" src="https://github.com/DataAsh21/SQL-Projects/assets/133566238/8dd28a83-e497-457c-ab94-14832cd31f19">

~~~
select [dbo].[Patient].Name as "Patient",
       [dbo].[Physician].Name as "Physician",
       [dbo].[Medication].Name as "Physician"
from [dbo].[Patient]
join [dbo].[Prescribes] on [dbo].[Patient].SSN = [dbo].[Prescribes].Patient
join [dbo].[Physician] on [dbo].[Prescribes].Physician = [dbo].[Physician].EmployeeID
join [dbo].[Medication] on [dbo].[Prescribes].Medication = [dbo].[Medication].Code
~~~

#### 20. From the following tables, write a SQL query to identify patients who have made an advanced appointment. Return Patient name as "Patient", Physician name as "Physician" and Medication name as "Medication".
~~~
select [dbo].[Patient].Name as "Patient",
       [dbo].[Physician].Name as "Physician",
       [dbo].[Medication].Name as "Physician"
from [dbo].[Patient]
join [dbo].[Prescribes] on [dbo].[Patient].SSN = [dbo].[Prescribes].Patient
join [dbo].[Physician] on [dbo].[Prescribes].Physician = [dbo].[Physician].EmployeeID
join [dbo].[Medication] on [dbo].[Prescribes].Medication = [dbo].[Medication].Code
where [dbo].[Prescribes].Appointment is not null;
~~~

#### 21. From the following tables, write a SQL query to find those patients who did not schedule an appointment. Return Patient name as "Patient", Physician name as "Physician" and Medication name as "Medication".

~~~
select [dbo].[Patient].Name as "Patient",
       [dbo].[Physician].Name as "Physician",
       [dbo].[Medication].Name as "Physician"
from [dbo].[Patient]
join [dbo].[Prescribes] on [dbo].[Patient].SSN = [dbo].[Prescribes].Patient
join [dbo].[Physician] on [dbo].[Prescribes].Physician = [dbo].[Physician].EmployeeID
join [dbo].[Medication] on [dbo].[Prescribes].Medication = [dbo].[Medication].Code
where [dbo].[Prescribes].Appointment is  nul
~~~

#### 22. From the following table, write a SQL query to count the number of available rooms in each block. Sort the result-set on ID of the block. Return ID of the block as "Block", count number of available rooms as "Number of available rooms".

<img width="539" alt="Screenshot 2023-09-22 150918" src="https://github.com/DataAsh21/SQL-Projects/assets/133566238/e188ca08-3ec4-4100-a7cc-888cc5900f7d">

~~~
SELECT COUNT(*) AS  "Number of available rooms",[BlockCode]
FROM [dbo].[Room]
WHERE [Unavailable] = 'FALSE'
GROUP BY [BlockCode]
ORDER BY [BlockCode]
~~~

#### 23. From the following table, write a SQL query to count the number of available rooms in each floor. Sort the result-set on block floor. Return floor ID as "Floor" and count the number of available rooms as "Number of available rooms".
~~~
SELECT COUNT(*) AS  "Number of available rooms",[BlockFloor]
FROM [dbo].[Room]
WHERE [Unavailable] = 'FALSE'
GROUP BY [BlockFloor]
ORDER BY [BlockFloor]
~~~

#### 24. From the following table, write a SQL query to count the number of available rooms for each floor in each block. Sort the result-set on floor ID, ID of the block. Return the floor ID as "Floor", ID of the block as "Block", and number of available rooms as "Number of available rooms".

~~~
SELECT COUNT(*) AS "Number of available rooms", [BlockFloor] AS "Floor", [BlockCode] AS "Block"
FROM [dbo].[Room]
WHERE [Unavailable] = 'FALSE'
GROUP BY [BlockFloor],[BlockCode]
ORDER BY [BlockFloor],[BlockCode]
~~~

#### 25. From the following tables, write a SQL query to count the number of rooms that are unavailable in each block and on each floor. Sort the result-set on block floor, block code. Return the floor ID as "Floor", block ID as "Block", and number of unavailable as “Number of unavailable rooms".

~~~
SELECT COUNT(*) AS "Number of available rooms", [BlockFloor] AS "Floor", [BlockCode] AS "Block"
FROM [dbo].[Room]
WHERE [Unavailable] = 'TRUE'
GROUP BY [BlockFloor],[BlockCode]
ORDER BY [BlockFloor],[BlockCode]
~~~

#### 26. From the following tables, write a SQL query to find the floor where the maximum number of rooms are available. Return floor ID as "Floor", count "Number of available rooms".

~~~
SELECT TOP 1 COUNT(*) AS  "Number of available rooms",[BlockFloor]
FROM [dbo].[Room]
WHERE [Unavailable] = 'FALSE'
GROUP BY [BlockFloor]
ORDER BY [BlockFloor]
~~~

#### 27. From the following tables, write a SQL query to locate the floor with the minimum number of available rooms. Return floor ID as "Floor", Number of available rooms.

~~~
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
~~~

#### 28. From the following tables, write a SQL query to find the name of the patients, their block, floor, and room number where they admitted.
<img width="541" alt="Screenshot 2023-09-22 151637" src="https://github.com/DataAsh21/SQL-Projects/assets/133566238/95d560a7-1c6e-4d25-93cd-34fb4b42aa89">

~~~
SELECT [dbo].[Patient].Name AS NAME,[dbo].[Room].BlockFloor AS FLOOR, [dbo].[Room].BlockCode AS CODE, [dbo].[Stay].[Room] AS ROOM
FROM [dbo].[Stay]
JOIN [dbo].[Patient] ON [dbo].[Stay].[Patient] = [dbo].[Patient].[SSN]
JOIN [dbo].[Room] ON [dbo].[Stay].[Room] = [dbo].[Room].[Number]
~~~

#### 29. From the following tables, write a SQL query to locate the nurses and the block where they are scheduled to attend the on-call patients.Return Nurse Name as "Nurse", Block code as "Block".
<img width="538" alt="Screenshot 2023-09-22 151759" src="https://github.com/DataAsh21/SQL-Projects/assets/133566238/7f5083d5-b7cb-42bc-9759-9cdfae870c1c">

~~~
select [dbo].[Nurse].Name as "Nurse",[dbo].[On_Call].BlockCode as "Block"
from [dbo].[Nurse]
join [dbo].[On_Call] on [dbo].[Nurse].EmployeeID = [dbo].[On_Call].Nurse;
~~~

#### 30. From the following tables, write a SQL query to get
- a) name of the patient,
- b) name of the physician who is treating him or her,
- c) name of the nurse who is attending him or her,
- d) which treatement is going on to the patient,
- e) the date of release,
- f) in which room the patient has admitted and which floor and block the room belongs to respectively.
<img width="541" alt="Screenshot 2023-09-22 152026" src="https://github.com/DataAsh21/SQL-Projects/assets/133566238/933f0111-c4d7-40c4-89ee-5301f474c1ee">
<img width="539" alt="Screenshot 2023-09-22 152043" src="https://github.com/DataAsh21/SQL-Projects/assets/133566238/cef78504-d122-4c24-a4b2-881f5085c0e2">

~~~
select [dbo].[Patient].[Name] as patient,[dbo].[Physician].Name as physician,[dbo].[Nurse].Name as nurse,[dbo].[Stay].Ends as "date of release",
[dbo].[Room].[Number],[dbo].[Room].[BlockFloor],[dbo].[Room].[BlockCode]
from [dbo].[Undergoes]
join [dbo].[Patient] on [dbo].[Undergoes].[Patient] =[dbo].[Patient].SSN
join[dbo].[Physician] on [dbo].[Undergoes].Physician = [dbo].[Physician].EmployeeID
left join[dbo].[Nurse] on [dbo].[Undergoes].[AssistingNurse] = [dbo].[Nurse].EmployeeID
join [dbo].[Stay] on [dbo].[Undergoes].Stay = [dbo].[Stay].StayID
join [dbo].[Room] on [dbo].[Stay].Room = [dbo].[Room].Number
~~~

#### 31. From the following tables, write a SQL query to find all physicians who have performed a medical procedure but are not certified to do so. Return Physician name as "Physician".
<img width="542" alt="Screenshot 2023-09-22 152212" src="https://github.com/DataAsh21/SQL-Projects/assets/133566238/a9661c10-fbcc-49c4-9cb2-64b6131a4b9c">

~~~
SELECT p.name AS "Physician"
FROM physician p
JOIN undergoes u ON p.employeeid = u.physician
 left JOIN trained_in t ON u.physician = t.physician AND u.Procedures = t.treatment
WHERE t.treatment IS NULL;
~~~

#### 32. From the following tables, write a SQL query to find all physicians, their procedures, the date when the procedure was performed, and the name of the patient on whom the procedure was performed, but the physicians are not certified to perform that procedure. Return Physician Name as "Physician", Procedure Name as "Procedure", date, and Patient. Name as "Patient".
<img width="538" alt="Screenshot 2023-09-22 152322" src="https://github.com/DataAsh21/SQL-Projects/assets/133566238/d53d6133-89bf-4070-90ea-46d32b60d243">
<img width="542" alt="Screenshot 2023-09-22 152336" src="https://github.com/DataAsh21/SQL-Projects/assets/133566238/edb5bb07-8c7f-4ef0-b7b4-6364bdec4a5a">

~~~
select [dbo].[Physician].Name,[dbo].[Procedures].Name,[dbo].[Undergoes].Date,[dbo].[Patient].Name
from [dbo].[Physician]
join [dbo].[Undergoes] on [dbo].[Physician].EmployeeID = [dbo].[Undergoes].Physician
join [dbo].[Patient] on [dbo].[Undergoes].Patient = [dbo].[Patient].SSN
join[dbo].[Procedures] on [dbo].[Undergoes].Procedures = [dbo].[Procedures].Code
left join[dbo].[Trained_In] on [dbo].[Procedures].Code = [dbo].[Trained_In].Treatment
and [dbo].[Trained_In].Physician = [dbo].[Physician].EmployeeID
WHERE [dbo].[Trained_In].Treatment IS NULL;
~~~

#### 33. From the following table, write a SQL query to find all physicians who completed a medical procedure with certification after the expiration date of their license. Return Physician Name as "Physician", Position as "Position".
<img width="540" alt="Screenshot 2023-09-22 152501" src="https://github.com/DataAsh21/SQL-Projects/assets/133566238/b2b1911a-23f0-406a-9be1-9fa2a293ef5a">

~~~
select  [dbo].[Physician].Name as "Physician", [dbo].[Physician].Position as "Position"
from [dbo].[Physician]
join [dbo].[Undergoes] on [dbo].[Physician].EmployeeID = [dbo].[Undergoes].Physician
join [dbo].[Trained_In] on [dbo].[Undergoes].Physician = [dbo].[Trained_In].Physician
and [dbo].[Undergoes].Procedures = [dbo].[Trained_In].Treatment
where [dbo].[Undergoes].Date > [dbo].[Trained_In].CertificationExpires;
~~~

#### 34. From the following table, write a SQL query to find all physicians who have completed medical procedures with certification after their certificates expired. Return Physician Name as "Physician", Position as" Position", Procedure Name as "Procedure", Date of Procedure as "Date of Procedure", Patient Name as "Patient", and expiry date of certification as "Expiry Date of Certificate".
<img width="540" alt="Screenshot 2023-09-22 152614" src="https://github.com/DataAsh21/SQL-Projects/assets/133566238/02e55a61-23af-4764-9f1c-7b9ae6690670">
<img width="540" alt="Screenshot 2023-09-22 152628" src="https://github.com/DataAsh21/SQL-Projects/assets/133566238/2f1412aa-2618-438d-913c-ed77c73a989e">

~~~
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
~~~

#### 35. From the following table, write a SQL query to find out, which nurses have been on call for room 122 in the past. Return name of the nurses.

<img width="543" alt="Screenshot 2023-09-22 152752" src="https://github.com/DataAsh21/SQL-Projects/assets/133566238/426a52f2-bcf9-4972-a8bb-b7cd2cdc7c9c">

~~~
select [dbo].[Nurse].Name as nurses
from [dbo].[Nurse]
join [dbo].[On_Call] on [dbo].[Nurse].EmployeeID = [dbo].[On_Call].Nurse
join [dbo].[Room] on [dbo].[On_Call].BlockCode = [dbo].[Room].BlockCode
and [dbo].[On_Call].BlockFloor = [dbo].[Room].BlockFloor
where [dbo].[Room].Number = 122;
~~~

#### 36. From the following table, write a SQL query to determine which patients have been prescribed medication by their primary care physician. Return Patient name as "Patient", and Physician Name as "Physician".

<img width="540" alt="Screenshot 2023-09-22 152854" src="https://github.com/DataAsh21/SQL-Projects/assets/133566238/d3339357-e869-435a-84e1-982571f22b75">

~~~
select [dbo].[Patient].Name as "Patient" ,[dbo].[Physician].Name as "Physician"
from [dbo].[Patient]
join [dbo].[Prescribes] on [dbo].[Patient].SSN = [dbo].[Prescribes].Patient
join [dbo].[Physician] on [dbo].[Patient].PCP = [dbo].[Physician].EmployeeID
where [dbo].[Patient].PCP = [dbo].[Prescribes].Physician
and [dbo].[Patient].PCP = [dbo].[Physician].EmployeeID
~~~

#### 37. From the following table, write a SQL query to find those patients who have undergone a procedure costing more than $5,000, as well as the name of the physician who has provided primary care, should be identified. Return name of the patient as "Patient", name of the physician as "Primary Physician", and cost for the procedure as "Procedure Cost".
<img width="542" alt="Screenshot 2023-09-22 153009" src="https://github.com/DataAsh21/SQL-Projects/assets/133566238/056339da-3bfe-431b-9079-ce37c37c12cd">
<img width="542" alt="Screenshot 2023-09-22 153025" src="https://github.com/DataAsh21/SQL-Projects/assets/133566238/253a41bb-4f39-4e23-84fa-f6d1cca222ed">

~~~
SELECT pt.name AS " Patient ",
p.name AS "Primary Physician",
pd.cost AS " Procedure Cost"
FROM patient pt
JOIN undergoes u ON u.patient=pt.ssn
JOIN physician p ON pt.pcp=p.employeeid
JOIN Procedures pd ON u.Procedures=pd.code
WHERE pd.cost>5000;
~~~

#### 38. From the following table, write a SQL query to find those patients with at least two appointments in which the nurse who prepared the appointment was a registered nurse and the physician who provided primary care should be identified. Return Patient name as "Patient", Physician name as "Primary Physician", and Nurse Name as "Nurse".
<img width="542" alt="Screenshot 2023-09-22 153231" src="https://github.com/DataAsh21/SQL-Projects/assets/133566238/469ece40-4336-4bf6-b1f2-137a7cb6fca2">
<img width="541" alt="Screenshot 2023-09-22 153250" src="https://github.com/DataAsh21/SQL-Projects/assets/133566238/7a83d723-e997-4809-b8c4-110378e8b379">

~~~
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
~~~

#### 39. From the following table, write a SQL query to identify those patients whose primary care is provided by a physician who is not the head of any department. Return Patient name as "Patient", Physician Name as "Primary care Physician".

<img width="540" alt="Screenshot 2023-09-22 153408" src="https://github.com/DataAsh21/SQL-Projects/assets/133566238/d3be8dc6-1ff6-4392-82cf-6b1ef7a9285f">

~~~
SELECT pt.name AS "Patient",
       p.name AS "Primary care Physician"
FROM patient pt
JOIN physician p ON pt.pcp=p.employeeid
WHERE pt.pcp NOT IN
    (SELECT head
     FROM department);
~~~














