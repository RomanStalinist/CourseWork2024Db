USE [Healthcare]
GO

-- ������������� ������ � ������ ������ ������������
CREATE OR ALTER VIEW CurrentConsultationsView AS
SELECT
    C.Id [��� ������������],
    C.StartTime [������],
    C.EndTime [�����],
    DP.Name [��� �������],
	DP.Surname [������� �������],
	DP.FatherName [�������� �������],
    PP.Name [��� ��������],
    PP.Surname [������� ��������],
	PP.FatherName [�������� ��������]
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

-- ������������� ��� ���� ��������
CREATE OR ALTER VIEW PrescriptionsDetailsView AS
SELECT 
    R.Id [��� �������],
    R.Description [�������� �������],
    M.Name AS [������������ ���������],
    C.StartTime [������ ������������],
    C.EndTime [����� ������������],
    PP.Name [��� ��������],
    PP.Surname [������� ��������],
	PP.FatherName [�������� ��������]
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

-- ������������� ��������� �� �������������
CREATE OR ALTER VIEW ConsultationSymptomsView AS
SELECT 
    C.Id AS [��� ������������],
    STRING_AGG(S.Name, ', ') AS [��������],  -- ���������� �������� � ������, �������� �������
    PP.Name AS [��� ��������],
    PP.Surname AS [������� ��������],
    PP.FatherName AS [�������� ��������],
    DP.Name AS [��� �������],
    DP.Surname AS [������� �������],
    DP.FatherName AS [�������� �������],
    C.StartTime [������ ������������],
    C.EndTime [����� ������������]
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
    C.Id, PP.Name, PP.Surname, PP.FatherName, DP.Name, DP.Surname, DP.FatherName, C.StartTime, C.EndTime;  -- ���������� �� ���� �����, ����� ���������
GO

-- ������������� ������ �� �������������
CREATE OR ALTER VIEW DoctorsBySpecialtyView AS
SELECT 
    D.Specialty [�������������],
    COUNT(D.Id) [���������� ��������]
FROM 
    dbo.Doctors D
GROUP BY 
    D.Specialty
GO
