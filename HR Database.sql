--- HR Project Goal
  -- Data normalization
  -- Data Cleaning
  -- Adding Constraint

-- Querying
	-- Procedure 

--------------------------------------------------------------
-- Create Database
-- Import the file | File Link:
        -- Raw data is nasa isang table lang which is not a good practice, so that I need to normalize it, and put it to their desinated tables

-------------------------------------------------- Data Cleaning & Normalization
        --  Gender | Normalization |
        --Transfering the data into DimGender Table
SELECT
  	DISTINCT(GenderID),
  	Sex
INTO
  	DimGender
FROM
  	HRDataset_v14

--  EmploymentStatus | Normalization |
        -- In DimEmpstatus, the emp status id 1 2 3's value is active and there are also an id 1 with "terminated for cause: value, id 4 is Terminated for Cause and Id 5 is Voluntarily Terminated but I  will replace Terminated for Cause to id 2 and Voluntarily Terminated to 3 to have a organize number

UPDATE HRDataset_v14
SET EmpStatusID = 4
WHERE EmploymentStatus = 'Terminated for Cause'

UPDATE HRDataset_v14
SET EmpStatusID = 1
WHERE EmploymentStatus ='Active'

	 Organizing
UPDATE HRDataset_v14
SET EmpStatusID = 2
WHERE EmploymentStatus = 'Terminated for Cause'

UPDATE HRDataset_v14
SET EmpStatusID = 3
WHERE EmploymentStatus = 'Voluntarily Terminated'

        --Transfering into DimEmploymentStatus Table
SELECT
	DISTINCT(EmpStatusID),
	EmploymentStatus
INTO
	DimEmploymentStatus
FROM
	HRDataset_v14

--  Department | Normalization |
        -- Some Id and department is duplcate, so need to clean.

UPDATE HRDataset_v14
SET DeptID = 4
WHERE Department = 'Software Engineering'

UPDATE HRDataset_v14
SET DeptID = 5
WHERE Department = 'Production'

        --Transfer the data into DimDepartment
SELECT
	DISTINCT(DeptID),
	Department
INTO
	DimDepartment
FROM
	HRDataset_v14

-- PerformaceScore | Normalization |
	-- Data Cleaning
UPDATE HRDataset_v14
SET PerfScoreID = 2
WHERE PerformanceScore = 'PIP'

UPDATE HRDataset_v14
SET PerformanceScore = 'Needs Improvement'
WHERE PerfScoreID = 2

UPDATE HRDataset_v14
SET PerfScoreID = 1
WHERE PerformanceScore = 'Fully Meets'

UPDATE HRDataset_v14
SET PerfScoreID = 3
WHERE PerformanceScore ='Exceeds'
	-- Transfering the data into DimPerformanceScore Table
Select 
	DISTINCT(PerfScoreID),
	PerformanceScore
INTO
	DimPerformanceScore
From 
	HRDataset_v14

-- DimPosition | Normalization |
	-- Data Cleaning
UPDATE HRDataset_v14
SET PositionID = 24
WHERE Position = 'Software Engineer'

UPDATE HRDataset_v14
SET PositionID = 18
WHERE Position = 'Production Manager'

UPDATE HRDataset_v14
SET Position = 'IT Manager'
WHERE PositionID = 13
-- Transfering the data into DimPosition Table
SELECT
	DISTINCT(PositionID),
	Position
INTO
	DimPosition
FROM
	HRDataset_v14

-- DimMaritalStatus | Normalization |
	-- MaritalStatus Data is clean.
	-- Transfering the data into DimMaritalStatus Table
SELECT
	DISTINCT(MaritalStatusID),
	MaritalDesc
INTO
	DimMaritalStatus
FROM
	HRDataset_v14

-- DimManager
	-- Data Cleaning
UPDATE HRDataset_v14
SET ManagerID = 39
WHERE ManagerName = 'Webster Butler'

UPDATE HRDataset_v14
SET ManagerID = 22
WHERE ManagerName = 'Michael Albert'

UPDATE HRDataset_v14
SET ManagerID = 1
WHERE ManagerName = 'Brandon R. LeBlanc'
	-- Transfering the data into DimManager Table
SELECT
	DISTINCT(ManagerID),
	ManagerName
INTO
	DimManager
FROM
	HRDataset_v14

----- EmpSatisfaction | Normalization |
	-- Employment Satisfaction has missing information, so I reasearch on what is the corresponing value of each number and improvise the data base on data that i researched.
	-- Transfering the one column to its designated Table
SELECT
	DISTINCT(EmpSatisfaction) AS EmpSatisfactionID
INTO
	DimEmpSatisfaction
FROM
	HRDataset_v14
	-- Adding EmpSatisfaction column to for the the value of the ID
ALTER TABLE DimEmpSatisfaction
ADD EmpSatisfaction NVARCHAR(20)
	-- This is the data I research that I will put on my project
	---- Add customize value from google, Add column
		--1	Very Dissatisfied
		--2	Dissatisfied
		--3	Nuetral
		--4	Satisfied
		--5	Very Satisfied

	-- Entering the data
UPDATE DimEmpSatisfaction
SET EmpSatisfaction = 'Very Dissatisfied'
WHERE EmpSatisfactionID = 1

UPDATE DimEmpSatisfaction
SET EmpSatisfaction = 'Dissatisfied'
WHERE EmpSatisfactionID = 2

UPDATE DimEmpSatisfaction
SET EmpSatisfaction = 'Nuetral'
WHERE EmpSatisfactionID = 3

UPDATE DimEmpSatisfaction
SET EmpSatisfaction = 'Satisfied'
WHERE EmpSatisfactionID = 4

UPDATE DimEmpSatisfaction
SET EmpSatisfaction = 'Very Satisfied'
WHERE EmpSatisfactionID = 5

-- Employee | Normalization |
	-- Transfering the choosen column to its designated table which is DimEmployee
SELECT 
	 EmpID,
	 Employee_Name AS EmployeeName,
	 Salary,
	 State,
	 Zip,
	 DOB AS DateOFBirth,
	 CitizenDesc,
	 RaceDesc,
	 DateofHire,
	 DateofTermination,
	 TermReason,
	 RecruitmentSource,
	 SpecialProjectsCount,
	 LastPerformanceReview_Date,
	 DaysLateLast30,
	 Absences
INTO
	DimEmployee
FROM 
	HRDataset_v14

--HRRecord | Normalization |
	-- Transfering the data into FactHRRecord Table
SELECT
	EmpID,
	MarriedID,
	MaritalStatusID,
	GenderID,
	EmpStatusID,
	DeptID,
	PerfScoreID,
	PositionID,
	ManagerID,
	EmpSatisfaction AS EmpSatisfactionID
INTO
	FactHRRecord
FROM 
	HRDataset_v14


----------------------------- Changing Data types based on the data inputs
--DimDepartment
ALTER TABLE DimDepartment
ALTER COLUMN DeptID INT NOT NULL

ALTER TABLE DimDepartment
ALTER COLUMN Department NVARCHAR(40) NOT NULL

-- DimEmployee
ALTER TABLE DimEmployee
ALTER COLUMN EmpID INT NOT NULL

ALTER TABLE DimEmployee
ALTER COLUMN EmployeeName NVARCHAR(250) NOT NULL

ALTER TABLE DimEmployee
ALTER COLUMN Salary MONEY NOT NULL

ALTER TABLE DimEmployee
ALTER COLUMN State NVARCHAR(5) NOT NULL

ALTER TABLE DimEmployee
ALTER COLUMN Zip INT NOT NULL

ALTER TABLE DimEmployee
ALTER COLUMN DateOfBirth DATE NOT NULL

ALTER TABLE DimEmployee
ALTER COLUMN CitizenDesc NVARCHAR(50) NOT NULL

ALTER TABLE DimEmployee
ALTER COLUMN RaceDesc NVARCHAR(50) NOT NULL

ALTER TABLE DimEmployee
ALTER COLUMN DateOFHire DATE NOT NULL

ALTER TABLE DimEmployee
ALTER COLUMN DateOFTermination DATE

ALTER TABLE DimEmployee
ALTER COLUMN TermReason NVARCHAR(250) NOT NULL

ALTER TABLE DimEmployee
ALTER COLUMN RecruitmentSource NVARCHAR(50) NOT NULL

ALTER TABLE DimEmployee
ALTER COLUMN SpecialProjectsCount INT NOT NULL

ALTER TABLE DimEmployee
ALTER COLUMN LastPerformanceReview_Date DATE NOT NULL

ALTER TABLE DimEmployee
ALTER COLUMN DaysLAteLast30 INT NOT NULL

ALTER TABLE DimEmployee
ALTER COLUMN Absences INT NOT NULL

-- DimEmploymentStatus
ALTER TABLE DimEmploymentStatus
ALTER COLUMN EmpStatusID INT NOT NULL

ALTER TABLE DimEmploymentStatus
ALTER COLUMN EmploymentStatus NVARCHAR(50) NOT NULL

-- DimEmpSatisfaction
ALTER TABLE DimEmpSatisfaction
ALTER COLUMN EmpSatisfactionID INT NOT NULL

ALTER TABLE DimEmpSatisfaction
ALTER COLUMN EmpSatisfaction NVARCHAR(50) NOT NULL

-- DimGender
ALTER TABLE DimGender
ALTER COLUMN GenderID INT NOT NULL

ALTER TABLE DimGender
ALTER COLUMN Sex NVARCHAR(1) NOT NULL

-- DimManager
ALTER TABLE DimManager
ALTER COLUMN ManagerID INT NOT NULL

ALTER TABLE DimManager
ALTER COLUMN ManagerName NVARCHAR(100) NOT NULL

--DimMaritalStatus
ALTER TABLE DimMaritalStatus
ALTER COLUMN MaritalStatusID INT NOT NULL

ALTER TABLE DimMaritalStatus
ALTER COLUMN MaritalDesc NVARCHAR(20) NOT NULL

--DimPerformanceScore
ALTER TABLE DimPerformanceScore
ALTER COLUMN PerfScoreID INT NOT NULL

ALTER TABLE DimPerformanceScore
ALTER COLUMN PerformanceScore NVARCHAR(20) NOT NULL

-- DimPosition
ALTER TABLE DimPosition
ALTER COLUMN PositionID INT NOT NULL

ALTER TABLE DimPosition
ALTER COLUMN Position NVARCHAR(100) NOT NULL


-- FactHRRecor
ALTER TABLE FactHRRecord
ALTER COLUMN EmpID INT NOT NULL

ALTER TABLE FactHRRecord
ALTER COLUMN MarriedID INT NOT NULL

ALTER TABLE FactHRRecord
ALTER COLUMN MaritalStatusID INT NOT NULL

ALTER TABLE FactHRRecord
ALTER COLUMN GenderID INT NOT NULL

ALTER TABLE FactHRRecord
ALTER COLUMN EmpStatusID INT NOT NULL

ALTER TABLE FactHRRecord
ALTER COLUMN DeptID INT NOT NULL

ALTER TABLE FactHRRecord
ALTER COLUMN PerfScoreID INT NOT NULL

ALTER TABLE FactHRRecord
ALTER COLUMN PositionID INT NOT NULL

ALTER TABLE FactHRRecord
ALTER COLUMN ManagerID INT NOT NULL

ALTER TABLE FactHRRecord
ALTER COLUMN EmpSatisfactionID INT  NOT NULL

-------------------------------------- Adding  Primary Constraints
ALTER TABLE DimGender
ADD CONSTRAINT PK_Gender
PRIMARY KEY (GenderID)

ALTER TABLE DimEmploymentStatus
ADD CONSTRAINT PK_EmploymentStatus
PRIMARY KEY(EmpStatusID)

ALTER TABLE DimDepartment
ADD CONSTRAINT PK_Department
PRIMARY KEY(DeptID)

ALTER TABLE DimPerformanceScore
ADD CONSTRAINT PK_PerformanceScore
PRIMARY KEY(PerfScoreID)

ALTER TABLE DimPosition
ADD CONSTRAINT PK_Position
PRIMARY KEY(PositionID)

ALTER TABLE DimEmployee
ADD CONSTRAINT PK_Employee
PRIMARY KEY(EmpID)

ALTER TABLE DimMaritalStatus
ADD CONSTRAINT PK_MaritalStatus
PRIMARY KEY(MaritalStatusID)

ALTER TABLE DimManager
ADD CONSTRAINT PK_Manager
PRIMARY KEY(ManagerID)

ALTER TABLE DimEmpSatisfaction
ADD CONSTRAINT PK_EmpSatisfaction
PRIMARY KEY(EmpSatisfactionID)

-------------------- Adding Foreign Key Constraint

ALTER TABLE FactHRRecord
ADD CONSTRAINT FK_Gender
FOREIGN KEY(GenderID)
REFERENCES DimGender(GenderID)

ALTER TABLE FactHRRecord
ADD CONSTRAINT FK_EmploymentStatus
FOREIGN KEY(EmpStatusID)
REFERENCES DimEmploymentStatus(EmpStatusID)

ALTER TABLE FactHRRecord
ADD CONSTRAINT FK_Department
FOREIGN KEY(DeptID)
REFERENCES DimDepartment(DeptID)

ALTER TABLE FactHRRecord
ADD CONSTRAINT FK_PerformanceScore
FOREIGN KEY (PerfScoreID)
REFERENCES DimPerformanceScore(PerfScoreID)

ALTER TABLE FactHRRecord
ADD CONSTRAINT FK_Employee
FOREIGN KEY (EmpID)
REFERENCES DimEmployee(EmpID)

ALTER TABLE FactHRRecord
ADD CONSTRAINT FK_MaritalStatus
FOREIGN KEY (MaritalStatusID)
REFERENCES DimMaritalStatus(MaritalStatusID)

ALTER TABLE FactHRRecord
ADD CONSTRAINT FK_Manager
FOREIGN KEY (ManagerID)
REFERENCES DimManager(ManagerID)

ALTER TABLE FactHRRecord
ADD CONSTRAINT FK_EmpSatisfaction
FOREIGN KEY	(EmpSatisfactionID)
REFERENCES DimEmpSatisfaction(EmpSatisfactionID)

ALTER TABLE FactHRRecord
ADD CONSTRAINT FK_Position
FOREIGN KEY (PositionID)
REFERENCES DimPosition(PositionID)
