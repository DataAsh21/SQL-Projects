
# Hospital Database 🏥
Hospitals play a critical role in providing medical care to individuals suffering from various illnesses and health conditions. Managing the day-to-day activities and records of a hospital manually can be challenging. 
This README.md file provides an overview of the hospital database structure, including the tables and their respective columns. 📋

![Sql_hospital](https://github.com/DataAsh21/SQL-Projects/assets/133566238/acb8f3c4-209e-412f-820f-b981121f4d7f)
## Tables 📊
## Physician 👨‍⚕️
- employeeid: Unique ID of a physician.
- name: Name of the physician.
- position: Designation of the physician.
- ssn: Security number of the physician.
## Department 🏥
- departmentid: Unique ID for a department.
- name: Name of the department.
- head: ID of the physician who is the head of the department, referencing the employeeid column of the physician table.
##  Affiliated_with 🤝
- physician: ID of physicians, referencing the employeeid column of the physician table.
- department: ID of the department, referencing the departmentid column of the department table.
- primaryaffiliation: Logical column indicating whether physicians are affiliated, default or not.
## Procedure 💉
- code: Unique ID of a medical procedure.
- name: Name of the medical procedure.
- cost: Cost for the procedure.
## Trained_in 🎓
- physician: ID of physicians, referencing the employeeid column of the physician table.
- treatment: ID of the medical procedure, referencing the code column of the procedure table.
- certificationdate: Starting date of certification.
- certificationexpires: Expiry date of certification.
## Patient 🏨
- ssn: Unique ID for each patient.
- name: Name of the patient.
- address: Address of the patient.
- phone: Phone number of the patient.
- insuranceid: Insurance ID of the patient.
- pcp: ID of the physician who primarily checked the patient, referencing the employeeid column of the physician table.
## Nurse 👩‍⚕️
- employeeid: Unique ID for a nurse.
- name: Name of the nurse.
- position: Designation of the nurse.
- registered: Logical column indicating whether the nurse is registered for nursing.
- ssn: Security number of a nurse.
## Appointment 📅
- appointmentid: Unique ID for an appointment.
- patient: ID of the patient, referencing the ssn column of the patient table.
- prepnurse: ID of the nurse attending the patient with the physician, referencing the employeeid column of the nurse table.
- physician: ID of the physician, referencing the employeeid column of the physician table.
- start_dt_time: Scheduled date and approximate time to meet the physician.
- end_dt_time: Scheduled date and approximate time to end the meeting.
- examinationroom: Room where the patient meets the physician.
## Medication 💊
- code: Unique ID for a medicine.
- name: Name of the medicine.
- brand: Brand of the medicine.
- description: Description of the medicine.
## Prescribes 📝
- physician: ID of the physician prescribing the medication, referencing the employeeid column of the physician table.
- patient: ID of the patient, referencing the ssn column of the patient table.
- medication: ID of the medicine, referencing the code column of the medication table.
- date: Date and time of the prescribed medication.
- appointment: Prescription made by the physician during a patient's appointment, referencing the appointmentid column of the appointment table.
- dose: Dose prescribed by the physician.
## Block 🏢
- blockfloor: ID of the floor.
- blockcode: ID of the block.
## Room 🏨
- roomnumber: Unique ID of a room.
- roomtype: Type of room.
- blockfloor: Floor ID where the room is located.
- blockcode: ID of the block where the room is located.
- unavailable: Logical column indicating room availability.
## On_call 🚑
- nurse: ID of the nurse on call, referencing the employeeid column of the nurse table.
- blockfloor: ID of the floor.
- blockcode: ID of the block.
- oncallstart: Starting date and time of on-call duration.
- oncallend: Ending date and time of on-call duration.
## Stay 🛏️
- stayid: Unique ID for an admission.
- patient: ID of the patient, referencing the ssn column of the patient table.
- room: ID of the room where the patient is admitted, referencing the roomnumber column of the room table.
- start_time: Time when a patient is admitted.
- end_time: Duration of the patient's stay.
## Undergoes 🚀
- patient: ID of the patient, referencing the ssn column of the patient table.
- procedure: ID of the procedure, referencing the code column of the procedure table.
- stay: ID of the patient's admission, referencing the stayid column of the stay table.
- date: Date when a patient undergoes a medical procedure.
- physician: ID of the physician performing the procedure, referencing the employeeid column of the physician table.
- assistingnurse: ID of the nurse assisting the physician, referencing the employeeid column of the nurse table.

Please note that the combinations mentioned in the notes for each table should be unique within their respective tables.

This database structure is designed to efficiently manage various aspects of hospital operations, including patient care, physician appointments, medical procedures, and more. 🌟
