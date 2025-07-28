# PMA - Patient Medical Archives Database

## Project Overview

The **PMA (Patient Medical Archives)** database is a centralized hospital management system designed to store and manage patient medical data, hospital departments, doctors, prescriptions, medical analyses, appointments, and related information. It enables hospitals to efficiently manage patient records and streamline healthcare operations.

---

## Objectives

- Enable hospitals to **register and access patient medical records** across the network.
- Provide patients with the ability to **view hospitals and book appointments**.
- Track **medical history including prescriptions, diagnoses, allergies, and lab results**.
- Maintain **accurate scheduling and availability of doctors and departments**.
- Ensure **data integrity and consistency** through relational schema design.

---

## Database Setup

1. **Install a Database Server**  
   Use MySQL, MariaDB, or any compatible relational database server.  
   Example: [Download MySQL](https://dev.mysql.com/downloads/mysql/)

2. **Create and Set Up the Database:**

   ```sql
   CREATE DATABASE pma;
   USE pma;
## Create Tables and Define Schema

- Patient  
- Doctor  
- Department  
- Hospital  
- Prescription  
- Medical_analysis  
- Appointment  
- Schedule  
- Allergy  
- Diagnose  
- Medicine  
- Prescribed  
- Date_Of_Prescription  
- Location_No  
- Location_Code  
- Patient_ID  

*(Refer to the SQL scripts provided for detailed `CREATE TABLE` statements with primary and foreign keys.)*

---

## Schema Design Highlights

- Relational design with **primary and foreign key constraints** to enforce data integrity.  
- Central **Patient** table linked to prescriptions, allergies, diagnoses, and medical analyses.  
- **Doctor** table connected to departments and prescriptions.  
- **Appointment** and **Schedule** tables handle bookings and availability.  
- **Hospital** and **Department** tables maintain organizational hierarchy and locations.  
- Use of **junction tables** (e.g., `Prescribed`, `Patient_ID`) to manage many-to-many relationships.

---

## Important Tables Overview

| Table Name          | Description                                         |
|---------------------|-----------------------------------------------------|
| Patient             | Stores patient personal info and demographics.      |
| Doctor              | Stores doctor details, department, and schedule.    |
| Prescription        | Records medicine details and prescription dates.    |
| Medical_analysis    | Stores results from lab tests and scans.            |
| Appointment         | Contains appointment schedules and pricing info.    |
| Allergy             | Lists patient allergies.                             |
| Diagnose            | Records patient diagnoses.                           |
| Department          | Departments within hospitals with contact info.     |
| Hospital            | Stores hospital codes, names, and locations.        |

---

## Example Advanced Queries

### 1. List doctors and the number of prescriptions they issued:

```sql
SELECT d.DrFname, d.DrLname, COUNT(p.MedicineName) AS PrescriptionCount  
FROM Doctor d  
JOIN Prescribed p ON d.License_Number = p.License_Number  
GROUP BY d.License_Number;
```

### 2. Get patients who have more than one allergy:

This query lists all patients who have been recorded with more than one allergy.

```sql
SELECT PatientID, COUNT(AllergyName) AS AllergyCount  
FROM Allergy  
GROUP BY PatientID  
HAVING COUNT(AllergyName) > 1;
```

### 3. Find appointments scheduled after 5 PM and the assigned doctors:

```sql
SELECT a.AppointmentNo, a.Date, a.Time, d.DrFname, d.DrLname
FROM Appointment a
JOIN Schedule s ON a.AppointmentNo = s.AppointmentNo
JOIN Doctor d ON s.LicenseNo = d.License_Number
WHERE d.Hour > 17;
```

### 4. Get the oldest patient(s) and their prescription details:

```sql
SELECT p.ID, p.PFirst_Name, p.PLast_Name, pr.MedicineName, pr.Prescription_Date
FROM Patient p
JOIN Prescription pr ON p.ID = pr.PatientID
WHERE p.Age = (SELECT MAX(Age) FROM Patient);
```
