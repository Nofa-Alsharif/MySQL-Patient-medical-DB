CREATE TABLE Prescription(
MedicineName             VARCHAR(30) NOT NULL,
Expiration_Date          VARCHAR(35),
Prescription_Date        VARCHAR(35) UNIQUE,
Repeat_Dispensing_Date   VARCHAR(35),
PatientID                INT(9) UNIQUE,
CONSTRAINT Prescription_PK PRIMARY KEY (MedicineName),
CONSTRAINT Prescription_FK FOREIGN KEY (PatientID)  REFERENCES Patient(ID)
);

CREATE TABLE Date_Of_Prescription (
Prescription_Date          VARCHAR(35) UNIQUE,
Repeat_Dispensing_Date     VARCHAR(35),
CONSTRAINT Date_Of_Prescription_PK PRIMARY KEY (Prescription_Date),
CONSTRAINT Date_Of_Prescription_FK FOREIGN KEY (Prescription_Date) REFERENCES Prescription(Prescription_Date)
);

CREATE TABLE Medicine (
MedicineName       VARCHAR(30) NOT NULL,
Expiration_Date    VARCHAR(35),
PatientID          INT(9) UNIQUE,
CONSTRAINT Medicine_PK PRIMARY KEY (MedicineName ),
CONSTRAINT Medicine_FK FOREIGN KEY (MedicineName) REFERENCES Prescription(MedicineName)
);

CREATE TABLE Prescribed (
MedicineName         VARCHAR(30) NOT NULL,
License_Number       INT(9) NOT NULL UNIQUE,
CONSTRAINT Prescribed_PK PRIMARY KEY (MedicineName,License_Number),
CONSTRAINT Prescribed_FK1 FOREIGN KEY (MedicineName) REFERENCES Prescription(MedicineName),
CONSTRAINT Prescribed_FK2 FOREIGN KEY (License_Number) REFERENCES Doctor(License_Number)
);

-- above (prescription,date of prescription, medicine, prescribed) was Maha

CREATE TABLE Patient (
  ID INT NOT NULL,
  Age INT ,
  Gender VARCHAR(1) ,
  Health_Insurance VARCHAR(45) ,
  PFirst_Name VARCHAR(15) ,
  PLast_Name VARCHAR(15) ,
  CONSTRAINT Patient_PK PRIMARY KEY (ID));
  
  CREATE TABLE Medical_analysis (
  Medical_Analysis VARCHAR(30) NOT NULL,
  CBC DECIMAL(20) ,
  Liver DECIMAL(20) ,
  Blood_glucose DECIMAL(20) ,
  Renal_functions DECIMAL(20) ,
  X_ray DATE ,
  MRI DATE ,
  CT_Scan DATE ,
  Urine DECIMAL(20) ,
  Faecal_Sample DECIMAL(20) ,
  CONSTRAINT Medical_Analysis_PK PRIMARY KEY (Medical_Analysis));
  
  CREATE TABLE Patient_ID (
  PatientID INT NOT NULL,
  Medical_Analysis VARCHAR(30) NOT NULL,
  CONSTRAINT PatientID_PK PRIMARY KEY (PatientID,Medical_Analysis),
  CONSTRAINT PatientID_FK1 FOREIGN KEY (PatientID) REFERENCES Patient(ID),
  CONSTRAINT PatientID_FK2 FOREIGN KEY (Medical_Analysis) REFERENCES Medical_Analysis(Medical_Analysis)
  );

  
CREATE TABLE Department 
( Department_code              VARCHAR(20) NOT NULL,
Phone_no           INT(10),
Hospital_code         VARCHAR(10) UNIQUE ,
CONSTRAINT Department_PK PRIMARY KEY (Department_code),
CONSTRAINT Department_FK1 FOREIGN KEY (Hospital_code) REFERENCES Hospital(Hospitalcode)
);

CREATE TABLE Doctor 
( License_number         INT(10) NOT NULL,
Hour        INT(2),
Minute    INT(2),
DrFname    VARCHAR (10),
DrLname     VARCHAR (10),
Department_code  VARCHAR(20),
CONSTRAINT Doctor_PK PRIMARY KEY (License_number),
CONSTRAINT Doctor_FK1 FOREIGN KEY (Department_code) REFERENCES Department(Department_code)
);

CREATE TABLE Diagnose(
PatientID INT (9) NOT NULL,
DiagnosisNo INT (10) NOT NULL UNIQUE,
CONSTRAINT Diagnose_PK PRIMARY KEY (PatientID,DiagnosisNo),
CONSTRAINT Diagnose_FK FOREIGN KEY(PatientID) REFERENCES Patient (ID));

CREATE TABLE Allergy(
PatientID INT (9) NOT NULL,
AllergyName VARCHAR(20) NOT NULL UNIQUE,
CONSTRAINT Allergy_PK PRIMARY KEY (PatientID,AllergyName),
CONSTRAINT Allergy_FK FOREIGN KEY(PatientID) REFERENCES Patient (ID));


-- From here..5

CREATE TABLE Hospital
(HospitalCode varchar(10)NOT NULL,
Name varchar(20),
PatientID INT(9) NOT NULL,
 CONSTRAINT Hospital_PK PRIMARY KEY (HospitalCode),
CONSTRAINT Hospital_FK FOREIGN KEY(PatientID) REFERENCES Patient (ID) ON DELETE CASCADE
 ) ;
CREATE TABLE Location_No
(LocationNumber varchar(5)NOT NULL,
 Street varchar(25),
City varchar(15),
 CONSTRAINT Location_No_PK PRIMARY KEY (LocationNumber)
) ;
CREATE TABLE Location_Code
(HospitalCode varchar(5)NOT NULL,
 LocationNumber varchar(5)NOT NULL,
CONSTRAINT Location_Code_PK PRIMARY KEY (HospitalCode, LocationNumber),
CONSTRAINT Location_Code_FK1 FOREIGN KEY(HospitalCode) REFERENCES Hospital (HospitalCode) ON DELETE CASCADE,
CONSTRAINT Location_Code_FK2 FOREIGN KEY(LocationNumber) REFERENCES Location_No (LocationNumber) ON DELETE CASCADE
) ;


SELECT DepartmentCode,COUNT(LicenseNumber) AS Available_Doctor # return the number of doctors available in each department after 5 pm
FROM Doctor
WHERE Hour>17
GROUP BY DepartmentCode;

SELECT COUNT(age) AS count_Patients,Gender # get the number of patients older than 20 from each gender.
FROM patient
WHERE age>=21
GROUP BY Gender;

-- 5..to here was by Ohoud

CREATE TABLE Appointment (
  AppointmentNo INT(10) NOT NULL,
  Price DECIMAL(5),
  Date DATE ,
  Time TIME ,

  Constraint Appointment_PK PRIMARY KEY (AppointmentNo));


CREATE TABLE Schedule (
    LicenseNo INT NOT NULL PRIMARY KEY ,
    AppointmentNo INT NOT NULL  ,
    PatientID INT NOT NULL, 
    constraint Schedule_FK1 foreign key (AppointmentNo) references Appointment(AppointmentNo) ,
	constraint Schedule_FK2  foreign key (PatientID) references Patient (ID)  

);

-- insert

INSERT INTO Prescription
    VALUE ('Zertil','2022-12-25','2022-3-15','2022-3-30',178352987),
          ('Metformin','2023-6-11','2022-11-11','2022-11-21',274629375),
          ('Omeprazole','2024-9-18','2022-7-01','2022-7-08',725975398),
          ('Ativan','2025-5-15','2022-2-02','2022-2-04',725839765), 
          ('Ocuvite','2023-1-27','2022-8-01','2022-9-01',726397654); 
-- Insert data into Date_Of_Prescription table
INSERT INTO Date_Of_Prescription (Prescription_Date, Repeat_Dispensing_Date)
VALUES 
  ('2022-03-15', '2022-03-30'),
  ('2022-11-11', '2022-11-21'),
  ('2022-07-01', '2022-07-08'),
  ('2022-02-02', '2022-02-04'),
  ('2022-08-01', '2022-09-01');

-- Insert data into Medicine table
INSERT INTO Medicine (MedicineName, Expiration_Date, PatientID)
VALUES 
  ('Zertil', '2022-12-25', 178352987),
  ('Metformin', '2023-06-11', 274629375),
  ('Omeprazole', '2024-09-18', 725975398),
  ('Ativan', '2025-05-15', 725839765),
  ('Ocuvite', '2023-01-27', 726397654);

-- Insert data into Prescribed table
INSERT INTO Prescribed (MedicineName, License_Number)
VALUES
  ('Zertil', 4),
  ('Metformin', 1),
  ('Omeprazole', 11),
  ('Ativan', 2),
  ('Ocuvite', 110);

INSERT INTO patient (ID, Age, Gender, PFirst_Name, PLast_Name) 
VALUES (178352987, 20, 'F', 'RAGHAD', 'YASEEN');

INSERT INTO patient (ID, Age, Gender, Health_Insurance, PFirst_Name, PLast_Name) 
VALUES (274629375, 78, 'M', 'Bupa', 'Yousef', 'Najar');

INSERT INTO patient (ID, Age, Gender, Health_Insurance, PFirst_Name, PLast_Name) 
VALUES (725975398, 39, 'F', 'Walaa', 'Tina', 'Smith');

INSERT INTO patient (ID, Age, Gender, PFirst_Name, PLast_Name) 
VALUES (725839765, 21, 'F', 'Nora', 'Alharbi');

INSERT INTO patient (ID, Age, Gender, Health_Insurance, PFirst_Name, PLast_Name) 
VALUES (726397654, 9, 'M', 'SAICO', 'Waleed', 'Nori');

INSERT INTO medical_analysis (Medical_Analysis, CBC, Liver, Blood_glucose, Renal_functions, X_ray, MRI, CT_Scan) 
VALUES ('AAA', 4.5, 23, 120, 0.7, '2022-06-30', '2020-05-05', '2020-05-29');

INSERT INTO medical_analysis (Medical_Analysis, CBC, Liver, Blood_glucose, Renal_functions, X_ray, Urine, Faecal_Sample) 
VALUES ('AAB', 4.7, 44, 100, 0.5, '2021-05-09', 89, 129);

INSERT INTO medical_analysis (Medical_Analysis, CBC, Liver, Blood_glucose, Renal_functions, Urine) 
VALUES ('ABA', 5.1, 55, 90, 0.9, 102);

INSERT INTO medical_analysis (Medical_Analysis, CBC, Liver, Blood_glucose, Renal_functions, X_ray, MRI, Faecal_Sample) 
VALUES ('ACB', 5.2, 57, 88, 1.0, '2010-10-22', '2015-08-07', 110);

INSERT INTO medical_analysis (Medical_Analysis, CBC, Liver, Blood_glucose, Renal_functions, X_ray, MRI, CT_Scan) 
VALUES ('ADD', 6.1, 46, 102, 1.3, '2019-10-09', '2022-02-11', '2017-09-12');


INSERT INTO patient_id (PatientID, Medical_Analysis)
VALUES (726397654,'ADD');

INSERT INTO patient_id (PatientID, Medical_Analysis)
VALUES (725839765,'ACB');

INSERT INTO patient_id (PatientID, Medical_Analysis)
VALUES (725975398,'ABA');

INSERT INTO patient_id (PatientID, Medical_Analysis)
VALUES (274629375,'AAB');

INSERT INTO patient_id (PatientID, Medical_Analysis)
VALUES (178352987,'AAA');


INSERT into Hospital
 VALUES ('1020','Bugshan', 725839765) ;
INSERT into Hospital
 VALUES ('1025','Dr. Soliman Fakeeh', 726397654) ;
INSERT into Hospital
 VALUES ('1511','Kingdom Hospital', 178352987) ;
INSERT into Hospital
 VALUES ('2204','king Khaled Hospital', 274629375) ;
INSERT into Hospital
 VALUES ('1111','king Faisal Hospital', 725975398) ;

INSERT into Location_No
 VALUES ('001','Tahlia','Jeddah') ;
INSERT into Location_No
 VALUES ('002','Palestine Square','Jeddah') ;
INSERT into Location_No
 VALUES ('003','Al Thumama','Riyadh') ;
INSERT into Location_No
 VALUES ('004','king Khaled street','Dammam') ;
INSERT into Location_No
 VALUES ('005','Hajj street','Makkah') ;

INSERT into Location_Code
 VALUES ('1020','001') ;
INSERT into Location_Code
 VALUES ('1025','002') ;
INSERT into Location_Code
 VALUES ('1511', '003') ;
INSERT into Location_Code
 VALUES ('2204','004') ;
INSERT into Location_Code
 VALUES ('1111', '005') ;

-- here
-- Insert appointments into the Appointment table
INSERT INTO Appointment
VALUES (1, 90, '2022-11-11', '14:00:00');

INSERT INTO Appointment
VALUES (3, 170, '2022-11-30', '12:30:00');

INSERT INTO Appointment
VALUES (14, 350, '2022-12-07', '10:20:00');

INSERT INTO Appointment
VALUES (19, 200, '2022-11-12', '17:15:00');

INSERT INTO Appointment
VALUES (22, 100, '2022-11-27', '08:00:00');

-- Insert schedules linking doctors to appointments and patients
INSERT INTO Schedule
VALUES (4, 1, 178352987);

INSERT INTO Schedule
VALUES (1, 3, 274629375);  -- Changed 001 to 1 for valid integer formatting

INSERT INTO Schedule
VALUES (11, 14, 725839765);

INSERT INTO Schedule
VALUES (2, 19, 726397654);

INSERT INTO Schedule
VALUES (110, 22, 725975398);


INSERT INTO pma.Department 
    VALUES('Surgical101', 552476030 , '1020');

INSERT INTO pma.Department 
    VALUES('Emergency201' , 552450132 , '1025');

INSERT INTO pma.Department 
    VALUES('Operating111' , 549221344 , '1511');

INSERT INTO pma.Department 
    VALUES('Dental clinic03' , 541132271 , '2204');

INSERT INTO pma.Department 
    VALUES('Dermatology104' ,556211833 , '1111');


INSERT INTO pma. Doctor
 VALUES (4 ,14, 30, 'Dr.Fatima' , 'Alshreef' , 'Dermatology104');

INSERT INTO pma. Doctor
 VALUES (001 , 18, 00, 'Dr.Noor' , 'Omar' , 'Emergency201');

INSERT INTO pma. Doctor
 VALUES (11,13, 15, 'Dr.Tom' , 'Smith ' , 'Dental clinic03');

INSERT INTO pma. Doctor
 VALUES (2, 22,00, 'Dr.Anns' , 'Abdulraham' , 'Surgical101');

INSERT INTO pma. Doctor
 VALUES (110,15,00, 'Dr.Ryiad' , 'Ahmad', 'Operating111');

-- Insert diagnoses for patients
INSERT INTO Diagnose (PatientID, DiagnosisNo)
VALUES 
  (178352987, 4), 
  (274629375, 2), 
  (725839765, 8), 
  (726397654, 5);

-- Insert allergies for patients
INSERT INTO Allergy (PatientID, AllergyName)
VALUES 
  (178352987, 'Gluten'),
  (274629375, 'Egg'),
  (725839765, 'Penicillin'),
  (726397654, 'Peanut');

---------------------------------------------------

-- Update the available time for a specific doctor
UPDATE pma.Doctor
SET Hour = 12, Minute = 00
WHERE Hour = 14 AND DrFname = 'Dr.Fatima';

-- Display all doctors to verify the update
SELECT * 
FROM pma.Doctor;

-- Update the phone number for a specific department
UPDATE pma.Department
SET Phone_no = 535911012
WHERE Department_code = 'Surgical101';

---------------------------------------------------

-- Delete diagnosis with DiagnosisNo = 2
DELETE FROM Diagnose
WHERE DiagnosisNo = 2;

-- Delete diagnosis with DiagnosisNo = 5
DELETE FROM Diagnose
WHERE DiagnosisNo = 5;

---------------------------------------------------

-- Subquery: Get the oldest patient(s) based on age
SELECT *
FROM Patient
WHERE Age = (SELECT MAX(Age) FROM Patient);

---------------------------------------------------

-- Subquery: List the names of patients who are older than the average age
SELECT PFirst_Name, Age
FROM Patient
WHERE Age > (SELECT AVG(Age) FROM Patient);

---------------------------------------------------

-- Count how many patients are male or female
SELECT Gender, COUNT(Gender) AS count
FROM Patient
GROUP BY Gender
HAVING COUNT(Gender) >= 1;

---------------------------------------------------

-- List all prescription info with medicine names and patient IDs in descending order
SELECT *
FROM Medicine
ORDER BY MedicineName DESC, PatientID DESC;

---------------------------------------------------

-- View how many doctors are available in each department after 5 PM
SELECT Department_code, COUNT(License_number) AS Available_Doctor
FROM Doctor
WHERE Hour > 17
GROUP BY Department_code;

---------------------------------------------------

-- Get the number of patients older than 60 for each gender
SELECT Gender, COUNT(age) AS count_Patients
FROM Patient
WHERE age > 60
GROUP BY Gender;

---------------------------------------------------

-- List all patients' IDs that have a gluten allergy
SELECT PatientID
FROM Allergy
WHERE AllergyName = 'gluten';

-- List all appointment prices from least expensive to most expensive
SELECT AppointmentNo, Price
FROM Appointment
ORDER BY Price ASC;

-- List patient ID, first and last name, and allergy
SELECT p.ID, p.PFirst_Name, p.PLast_Name, a.AllergyName
FROM Patient p
JOIN Allergy a ON p.ID = a.PatientID;

-- List doctors' license number, first name, and the medicine they prescribed
SELECT d.License_Number, d.DrFname, p.MedicineName
FROM Doctor d
JOIN Prescribed p ON d.License_Number = p.License_Number;

-- List patient ID, first and last name, and their medicine name
SELECT p.ID, p.PFirst_Name, p.PLast_Name, m.MedicineName
FROM Patient p
JOIN Medicine m ON p.ID = m.PatientID;


