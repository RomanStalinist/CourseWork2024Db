USE [Healthcare]
GO

-- Представление идущих в данный момент консультаций
CREATE OR ALTER VIEW CurrentConsultationsView AS
SELECT
    C.Id [Код консультации],
    C.StartTime [Начало],
    C.EndTime [Конец],
    DP.Name [Имя доктора],
	DP.Surname [Фамилия доктора],
	DP.FatherName [Отчество доктора],
    PP.Name [Имя пациента],
    PP.Surname [Фамилия пациента],
	PP.FatherName [Отчество пациента]
FROM 
    dbo.Consultations C
JOIN
    dbo.Doctors D ON D.Id = C.DoctorId
JOIN
	dbo.Passports DP ON DP.Id = D.PassportId
JOIN
    dbo.Patients P ON P.Id = C.PatientId
JOIN
	dbo.Passports PP ON PP.Id = P.PassportId
WHERE
	C.StartTime <= SYSDATETIME() AND C.EndTime >= SYSDATETIME()
GO

-- Представление для всех рецептов
CREATE OR ALTER VIEW PrescriptionsDetailsView AS
SELECT 
    R.Id [Код рецепта],
    R.Description [Описание рецепта],
    M.Name AS [Наименование лекарства],
    C.StartTime [Начало консультации],
    C.EndTime [Конец консультации],
    PP.Name [Имя пациента],
    PP.Surname [Фамилия пациента],
	PP.FatherName [Отчество пациента]
FROM 
    dbo.Prescriptions R
JOIN 
    dbo.Medicines M ON M.Id = R.MedicineId
JOIN 
    dbo.Consultations C ON C.Id = R.ConsultationId
JOIN 
    dbo.Patients P ON P.Id = C.PatientId
JOIN
	dbo.Passports PP ON PP.Id = P.PassportId
GO

-- Представление симптомов по консультациям
CREATE OR ALTER VIEW ConsultationSymptomsView AS
SELECT 
    C.Id AS [Код консультации],
    STRING_AGG(S.Name, ', ') AS [Симптомы],  -- Объединяем симптомы в строку, разделяя запятой
    PP.Name AS [Имя пациента],
    PP.Surname AS [Фамилия пациента],
    PP.FatherName AS [Отчество пациента],
    DP.Name AS [Имя доктора],
    DP.Surname AS [Фамилия доктора],
    DP.FatherName AS [Отчество доктора],
    C.StartTime [Начало консультации],
    C.EndTime [Конец консультации]
FROM 
    dbo.ConsultationSymptoms CS
JOIN 
    dbo.Consultations C ON C.Id = CS.ConsultationId
JOIN 
    dbo.Symptoms S ON S.Id = CS.SymptomId
JOIN 
    dbo.Patients P ON P.Id = C.PatientId
JOIN
    dbo.Passports PP ON PP.Id = P.PassportId
JOIN 
    dbo.Doctors D ON C.DoctorId = D.Id
JOIN
    dbo.Passports DP ON DP.Id = D.PassportId
GROUP BY 
    C.Id, PP.Name, PP.Surname, PP.FatherName, DP.Name, DP.Surname, DP.FatherName, C.StartTime, C.EndTime;  -- Группируем по всем полям, кроме Симптомов
GO

-- Представление врачей по специальности
CREATE OR ALTER VIEW DoctorsBySpecialtyView AS
SELECT 
    D.Specialty [Специальность],
    COUNT(D.Id) [Количество докторов]
FROM 
    dbo.Doctors D
GROUP BY 
    D.Specialty
GO
