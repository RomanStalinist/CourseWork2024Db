-- ������� ��� ���������� ���� [UpdatedAt] ��� UPDATE � dbo.Doctors
DROP TRIGGER IF EXISTS trg_UpdateDoctorTimestamp
GO

CREATE TRIGGER trg_UpdateDoctorTimestamp
ON dbo.Doctors
AFTER UPDATE
AS
BEGIN
    UPDATE dbo.Doctors
    SET UpdatedAt = SYSDATETIME()
    WHERE Id IN (SELECT DISTINCT Id FROM inserted)
END
GO

-- ������� ��� ���������� ���� [UpdatedAt] ��� UPDATE � dbo.Patients
DROP TRIGGER IF EXISTS trg_UpdatePatientTimestamp
GO

CREATE TRIGGER trg_UpdatePatientTimestamp
ON dbo.Patients
AFTER UPDATE
AS
BEGIN
    UPDATE dbo.Patients
    SET UpdatedAt = SYSDATETIME()
    WHERE Id IN (SELECT DISTINCT Id FROM inserted)
END
GO

-- ������� ��� ���������� ���� [UpdatedAt] ��� UPDATE � dbo.Users
DROP TRIGGER IF EXISTS trg_UpdateUserTimestamp
GO

CREATE TRIGGER trg_UpdateUserTimestamp
ON dbo.Users
AFTER UPDATE
AS
BEGIN
    UPDATE dbo.Users
    SET UpdatedAt = SYSDATETIME()
    WHERE Id IN (SELECT DISTINCT Id FROM inserted)
END
GO

-- ������� ��� ���������� ���� [UpdatedAt] ��� UPDATE � dbo.WorkingHours
DROP TRIGGER IF EXISTS trg_UpdateWorkingHourTimestamp
GO

CREATE TRIGGER trg_UpdateWorkingHourTimestamp
ON dbo.WorkingHours
AFTER UPDATE
AS
BEGIN
    UPDATE dbo.WorkingHours
    SET UpdatedAt = SYSDATETIME()
    WHERE Id IN (SELECT DISTINCT Id FROM inserted)
END
GO

-- ��������, ����� � Consultations StartTime ��� ������, ��� EndTime
DROP TRIGGER IF EXISTS trg_Consultations_InsertUpdate_DateTime_Check
GO

CREATE TRIGGER [dbo].[trg_Consultations_InsertUpdate_DateTime_Check]
ON [dbo].[Consultations]
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted
        WHERE EndTime <= StartTime
    )
    BEGIN
        RAISERROR (N'����� ������ ������������ �� ������ ���� ������ ��� ����� ������� � ���������', 16, 1)
        ROLLBACK TRAN
    END
END
