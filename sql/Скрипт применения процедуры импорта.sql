DELETE FROM Users
DBCC CHECKIDENT('Users', RESEED, 0)
DELETE FROM Roles
DBCC CHECKIDENT('Roles', RESEED, 0)
DELETE FROM ConsultationSymptoms
DBCC CHECKIDENT('ConsultationSymptoms', RESEED, 0)
DELETE FROM Symptoms
DBCC CHECKIDENT('Symptoms', RESEED, 0)
DELETE FROM Prescriptions
DBCC CHECKIDENT('Prescriptions', RESEED, 0)
DELETE FROM Consultations
DBCC CHECKIDENT('Consultations', RESEED, 0)
DELETE FROM Medicines
DBCC CHECKIDENT('Medicines', RESEED, 0)
DELETE FROM MedicineSideEffects
DBCC CHECKIDENT('MedicineSideEffects', RESEED, 0)
DELETE FROM MedicineUsingWays
DBCC CHECKIDENT('MedicineUsingWays', RESEED, 0)
DELETE FROM DozeUnits
DBCC CHECKIDENT('DozeUnits', RESEED, 0)
DELETE FROM WorkingHours
DBCC CHECKIDENT('WorkingHours', RESEED, 0)
DELETE FROM Doctors
DBCC CHECKIDENT('Doctors', RESEED, 0)
DELETE FROM Patients
DBCC CHECKIDENT('Patients', RESEED, 0)
DELETE FROM Passports
DBCC CHECKIDENT('Passports', RESEED, 0)

EXEC InsertDataFromCSV 'Passports', 'E:\CourseWork\csv\Passports.csv', TRUE
EXEC InsertDataFromCSV 'Patients', 'E:\CourseWork\csv\Patients.csv', TRUE
EXEC InsertDataFromCSV 'Doctors', 'E:\CourseWork\csv\Doctors.csv', TRUE
EXEC InsertDataFromCSV 'WorkingHours', 'E:\CourseWork\csv\WorkingHours.csv', TRUE
EXEC InsertDataFromCSV 'DozeUnits', 'E:\CourseWork\csv\DozeUnits.csv', TRUE
EXEC InsertDataFromCSV 'MedicineUsingWays', 'E:\CourseWork\csv\MedicineUsingWays.csv', TRUE
EXEC InsertDataFromCSV 'Medicines', 'E:\CourseWork\csv\Medicines.csv', TRUE
EXEC InsertDataFromCSV 'MedicineSideEffects', 'E:\CourseWork\csv\MedicineSideEffects.csv', TRUE
EXEC InsertDataFromCSV 'Consultations', 'E:\CourseWork\csv\Consultations.csv', TRUE
EXEC InsertDataFromCSV 'Prescriptions', 'E:\CourseWork\csv\Prescriptions.csv', TRUE
EXEC InsertDataFromCSV 'Symptoms', 'E:\CourseWork\csv\Symptoms.csv', TRUE
EXEC InsertDataFromCSV 'ConsultationSymptoms', 'E:\CourseWork\csv\ConsultationSymptoms.csv', TRUE
EXEC InsertDataFromCSV 'Roles', 'E:\CourseWork\csv\Roles.csv', TRUE
EXEC InsertDataFromCSV 'Users', 'E:\CourseWork\csv\Users.csv', TRUE