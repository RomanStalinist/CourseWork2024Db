-- EXEC InsertDataFromCSV 'Passports', 'E:\CourseWork\csv\Passports.csv', TRUE
EXEC InsertDataFromCSV 'Doctors', 'E:\CourseWork\csv\Doctors.csv', TRUE, @RowTerminator = '\n', @ShowSQL = TRUE
-- EXEC InsertDataFromCSV 'Medicines', 'E:\CourseWork\csv\Medicines.csv', TRUE