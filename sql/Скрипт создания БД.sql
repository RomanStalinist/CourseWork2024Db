USE [Healthcare]
GO

CREATE FULLTEXT CATALOG [FT_Catalog_IdentityDocuments] 
GO

CREATE TABLE [dbo].[Consultations](
    [Id] int IDENTITY NOT NULL PRIMARY KEY,
    [Location] nvarchar(100) NOT NULL,
    [StartTime] datetime2(7) NOT NULL,
    [EndTime] datetime2(7) NOT NULL,
    [DoctorId] int NULL FOREIGN KEY REFERENCES Doctors([Id]),
    [PatientId] int NULL FOREIGN KEY REFERENCES Patients([Id]),
    UNIQUE (StartTime, EndTime, DoctorId, PatientId)
)
GO

CREATE TABLE [dbo].[ConsultationSymptoms](
    [Id] int IDENTITY NOT NULL PRIMARY KEY,
    [SymptomId] int NULL FOREIGN KEY REFERENCES Symptoms([Id]),
    [ConsultationId] int NULL FOREIGN KEY REFERENCES Consultations([Id])
)
GO

CREATE TABLE [dbo].[Doctors](
    [Id] int IDENTITY NOT NULL PRIMARY KEY,
    [Specialty] nvarchar(50) NOT NULL,
    [Phone] nvarchar(20) NOT NULL,
    [Email] nvarchar(100) NOT NULL,
    [ExperienceYears] int NULL,
    [Address] nvarchar(200) NOT NULL,
    [CreatedAt] datetime2(7) NULL,
    [UpdatedAt] datetime2(7) NULL,
    [PassportId] int NULL FOREIGN KEY REFERENCES Passports([Id])
)
GO

CREATE TABLE [dbo].[DozeUnits](
    [Id] int IDENTITY NOT NULL PRIMARY KEY,
    [Name] nvarchar(20) NOT NULL
)
GO

CREATE TABLE [dbo].[Medicines](
    [Id] int IDENTITY NOT NULL PRIMARY KEY,
    [Name] nvarchar(100) NOT NULL,
    [DozeUnitId] int NULL FOREIGN KEY DozeUnits([Id]),
    [MedicineUsingWayId] int NULL FOREIGN KEY REFERENCES MedicineUsingWays([Id])
)
GO

CREATE TABLE [dbo].[MedicineSideEffects](
    [Id] int IDENTITY NOT NULL PRIMARY KEY,
    [Name] nvarchar(50) NOT NULL,
    [Description] nvarchar(200) NULL,
    [MedicineId] int NULL FOREIGN KEY REFERENCES Medicines([Id])
)
GO

CREATE TABLE [dbo].[MedicineUsingWays](
    [Id] int IDENTITY NOT NULL PRIMARY KEY,
    [Name] nvarchar(20) NULL
)
GO

CREATE TABLE [dbo].[Passports](
    [Id] int IDENTITY NOT NULL PRIMARY KEY,
    [Series] nvarchar(10) NOT NULL,
    [Number] nvarchar(20) NOT NULL,
    [Surname] nvarchar(30) NOT NULL,
    [Name] nvarchar(30) NOT NULL,
    [FatherName] nvarchar(30) NULL,
    [Sex] nchar(1) NULL CHECK ([Sex]=N'�' OR [Sex]=N'�'),
    [DateOfBirth] date NOT NULL
)
GO

CREATE TABLE [dbo].[Patients](
    [Id] int IDENTITY NOT NULL PRIMARY KEY,
    [PassportId] int NULL FOREIGN KEY REFERENCES Passports([Id]),
    [CreatedAt] datetime2(7) NULL,
    [UpdatedAt] datetime2(7) NULL
)
GO

CREATE TABLE [dbo].[Prescriptions](
    [Id] int IDENTITY NOT NULL PRIMARY KEY,
    [Description] nvarchar(200) NULL,
    [TimesInDay] int NOT NULL,
    [DozeCount] float NOT NULL,
    [CreatedAt] datetime2(7) NULL,
    [MedicineId] int NULL FOREIGN KEY REFERENCES Medicines([Id]),
    [ConsultationId] int NULL FOREGIN KEY REFERENCES Consultations([Id])
)
GO

CREATE TABLE [dbo].[Roles](
    [Id] int IDENTITY NOT NULL PRIMARY KEY,
    [Name] nvarchar(20) NOT NULL,
    [CreatedAt] datetime2(7) NULL
]
GO

CREATE TABLE [dbo].[Symptoms](
    [Id] int IDENTITY NOT NULL PRIMARY KEY,
    [Name] nvarchar(100) NOT NULL
)
GO

CREATE TABLE [dbo].[Users](
    [Id] int IDENTITY NOT NULL PRIMARY KEY,
    [Name] nvarchar(20) NOT NULL UNIQUE,
    [Password] nchar(60) NOT NULL,
    [Email] nvarchar(100) NOT NULL UNIQUE CHECK ([Email] LIKE '%_@__%.__%'),
    [Phone] nvarchar(20) NOT NULL UNIQUE,
    [CreatedAt] datetime2(7) NULL,
    [UpdatedAt] datetime2(7) NULL,
    [RoleId] int NULL FOREIGN KEY REFERENCES Roles([Id])
)
GO

CREATE TABLE [dbo].[WorkingHours](
    [Id] int IDENTITY NOT NULL PRIMARY KEY,
    [StartTime] time(7) NOT NULL,
    [EndTime] time(7) NOT NULL,
    [CreatedAt] datetime2(7) NULL,
    [UpdatedAt] datetime2(7) NULL,
    [DoctorId] int NULL FOREIGN KEY REFERENCES Doctors([Id]),
    [WorkDay] nvarchar(11) NULL
)
GO
