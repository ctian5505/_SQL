--- HR Project
  -- Data normalization
  -- Data Cleaning
  -- Adding Constraint

-- Querying

--------------------------------------------------------------
-- Create Database
-- Import the file | File Link:
        -- Raw data is nasa isang table lang which is not a good practice, so that I need to normalize it, and put it to their desinated tables

---------------------* Data Cleaning & Normalization
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

-- DimEmployee | Normalization |
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
