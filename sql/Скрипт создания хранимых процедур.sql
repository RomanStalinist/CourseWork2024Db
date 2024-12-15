-- ��������� ��� ������� ������ � ��������� ������� �� CSV-�����
CREATE OR ALTER PROC InsertDataFromCSV
    @TableName NVARCHAR(128),
    @AbsoluteFilePath NVARCHAR(500),
    @FirstRowContainsHeaders BIT = FALSE,
    @FieldTerminator NCHAR(1) = ',',
    @RowTerminator NVARCHAR(4) = '0x0a',
	@ShowSQL BIT = FALSE
AS
BEGIN
    DECLARE @SQL NVARCHAR(MAX)
	BEGIN TRAN
    
    SET @SQL = 'SET IDENTITY_INSERT ' + QUOTENAME(@TableName) + ' ON'
    EXEC sp_executesql @SQL

    -- ��������� ������� BULK INSERT
    SET @SQL = N'BULK INSERT ' + QUOTENAME(@TableName) + 
               N'FROM ' + QUOTENAME(@AbsoluteFilePath, '''') + 
               N'WITH (
					CODEPAGE = 65001,
					FIELDTERMINATOR = ''' + @FieldTerminator + ''',
					ROWTERMINATOR = ''' + @RowTerminator + ''',
					FIRSTROW = ' + IIF(@FirstRowContainsHeaders = 1, '2', '1') + '
				)'

    BEGIN TRY
		IF @ShowSQL = 1 PRINT @SQL
        EXEC sp_executesql @SQL
		COMMIT
        PRINT '������ ������� ���������.'
    END TRY
    BEGIN CATCH
        PRINT '��������� ������: ' + ERROR_MESSAGE()
		ROLLBACK
    END CATCH

    -- ��������� IDENTITY_INSERT �������
    SET @SQL = 'SET IDENTITY_INSERT ' + QUOTENAME(@TableName) + ' OFF'
    EXEC sp_executesql @SQL
END
GO

-- ��������� ��� ������ ���� ������������ ��������
CREATE OR ALTER PROC SelectPatientConsultations
    @PatientId INT
AS
    SELECT * FROM dbo.Consultations
    WHERE PatientId = @PatientId
GO

-- ��������� ��� ������ �������� �� �������������
CREATE OR ALTER PROC SelectDoctorsBySpecialty
    @Specialty NVARCHAR(50)
AS
    SELECT * FROM dbo.Doctors
    WHERE Specialty = @Specialty
GO

-- ��������� ��� ������ ��������, �������� �������� �� ��������� 30 ����
CREATE OR ALTER PROC SelectRecentPrescriptions
    @DoctorId INT
AS
    SELECT 
        R.Id AS PrescriptionId,
        R.Description,
        PP.Name AS PatientName,
        PP.Surname AS PatientSurname,
        C.StartTime
    FROM 
        dbo.Prescriptions R
    JOIN 
        dbo.Consultations C ON C.Id = R.ConsultationId
    JOIN 
        dbo.Patients P ON P.Id = C.PatientId
	JOIN
		dbo.Passports PP ON PP.Id = P.PassportId
    WHERE 
        C.DoctorId = @DoctorId AND C.StartTime >= DATEADD(DAY, -30, GETDATE())
GO
