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
