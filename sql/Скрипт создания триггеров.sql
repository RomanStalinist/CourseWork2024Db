-- Триггер для обновления поля [UpdatedAt] при UPDATE у dbo.Doctors
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

-- Триггер для обновления поля [UpdatedAt] при UPDATE у dbo.Patients
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

-- Триггер для обновления поля [UpdatedAt] при UPDATE у dbo.Users
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

-- Триггер для обновления поля [UpdatedAt] при UPDATE у dbo.WorkingHours
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

-- Проверка, чтобы в Consultations StartTime был раньше, чем EndTime
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
        RAISERROR (N'Время начала консультации не должно быть больше или равно времени её окончания', 16, 1)
        ROLLBACK TRAN
    END
END
