-- DQL(Data Query Language)
-----------------------------------------------------------------------------------------
-- 1. Create a stored procedure that will ask the user to input an employee ID, and if it is executed, it will display all information about the employee.
-- 2. Count the Total Employee
-- 3 . Count the Total Active Employee
-- 4 Rank the active employee Count base on department
-- 5 Count the active employee of each Manager
-- 6 Rank the employee based on their salary.
-- 7 Display the average salary by department.
-- 8 Create a stored procedure that asks the user to input the department name to show all employees together with their position.
-----------------------------------------------------------------------------------------
	-- 1. Create a stored procedure that will ask the user to input an employee ID, and if it is executed, it will display all information about the employee.
		CREATE PROCEDURE EmployeeInformation @EmployeeID INT
		AS
		BEGIN
		SELECT
			fhr.EmpID,
			de.EmployeeName,
			dg.Sex,
			de.DateOFBirth,
			YEAR(GETDATE()) - YEAR(de.DateOFBirth) AS Age,
			dms.MaritalDesc,
			de.State,
			de.Zip,
			de.RaceDesc,
			de.CitizenDesc,
			dd.Department,
			dp.Position,
			dm.ManagerName,
			de.DateofHire,
			de.Salary,
			de.LastPerformanceReview_Date,
			de.RecruitmentSource,
			des.EmploymentStatus,
			de.TermReason,
			de.DateofTermination,
			de.Absences,
			de.DaysLateLast30,
			de.SpecialProjectsCount
		FROM
			FactHRRecord AS fhr
		LEFT JOIN
			DimEmployee AS de
		ON
			fhr.EmpID = de.EmpID
		LEFT JOIN
			DimDepartment as dd
		ON
			fhr.DeptID = dd.DeptID
		LEFT JOIN
			DimEmploymentStatus AS des
		ON
			fhr.EmpStatusID = des.EmpStatusID
		LEFT JOIN
			DimEmpSatisfaction AS desat
		ON
			fhr.EmpSatisfactionID = desat.EmpSatisfactionID
		LEFT JOIN
			DimGender AS dg
		ON
			fhr.GenderID =dg.GenderID
		LEFT JOIN
			DimManager AS dm
		ON
			fhr.ManagerID = dm.ManagerID
		LEFT JOIN
			DimMaritalStatus AS dms
		ON
			fhr.MaritalStatusID = dms.MaritalStatusID
		LEFT JOIN
			DimPerformanceScore AS dpf
		ON 
			fhr.PerfScoreID  = dpf.PerfScoreID
		LEFT JOIN
			DimPosition as dp
		ON
			fhr.PositionID = dp.PositionID
		WHERE fhr.EmpID = @EmployeeID
	END
-- 2. Count the Total Employee
	SELECT
		COUNT(EmpID) AS TotalEmployee
	FROM
		DimEmployee

-- 3 . Count the Total Active Employee
	SELECT
		COUNT(de.EmpID) AS 'Total Active Employee'
	FROM
		DimEmployee AS de
	LEFT JOIN
		FactHRRecord AS fhr
	ON
		de.EmpID = fhr.EmpID
	LEFT JOIN
		DimEmploymentStatus AS des
	ON
		FHR.EmpStatusID = des.EmpStatusID
	WHERE 
		des.EmploymentStatus = 'Active'
	GROUP BY
		EmploymentStatus

-- 4 Rank the active employee Count base on department
	SELECT
		dd.Department,
		COUNT(fhr.EmpID) ActiveEmployeeCount,
		RANK() OVER (ORDER BY COUNT(fhr.EmpID) DESC) AS [Rank]
	FROM
		FactHRRecord AS fhr
	LEFT JOIN
		DimDepartment AS dd
	ON
		fhr.DeptID = dd.DeptID
	LEFT JOIN
		DimEmploymentStatus AS des
	ON
		fhr.EmpStatusID = des.EmpStatusID
	WHERE
		des.EmploymentStatus = 'Active'
	GROUP BY
		dd.Department

-- 5 Count the active employee of each Manager

SELECT
	dm.ManagerName,
	COUNT(EmpID) AS ActiveEmployeeCount
FROM
	FactHRRecord AS fhr
LEFT JOIN
	DimManager AS dm
ON
	fhr.ManagerID = dm.ManagerID
LEFT JOIN 
	DimEmploymentStatus AS des
ON
	fhr.EmpStatusID = des.EmpStatusID
WHERE
	des.EmploymentStatus = 'Active'
GROUP BY
	dm.ManagerName
ORDER BY
	ActiveEmployeeCount DESC

-- 6 Rank the employee based on their salary.
SELECT
	RANK() OVER (ORDER BY Salary DESC) AS Rank,
	EmployeeName, 
	Salary
FROM
	DimEmployee

-- 7 Display the average salary by department.
SELECT
	DISTINCT(Department),
	AVG(Salary) AS [Average Salary]
FROM
	FactHRRecord AS fhr
LEFT JOIN
	DimDepartment AS dd
ON
	fhr.DeptID = dd.DeptID
LEFT JOIN
	DimEmployee AS  de
ON
	fhr.EmpID = de.EmpID
GROUP BY
	Department

-- 8 Create a stored procedure that asks the user to input the department name to show all employees together with their position.

CREATE PROCEDURE Department @department_name NVARCHAR(250)
AS
BEGIN
SELECT
	de.EmployeeName,
	dd.Department,
	dp.Position
FROM
	FactHRRecord AS fhr
LEFT JOIN
	DimEmployee AS de
ON
	fhr.EmpID = de.EmpID
LEFT JOIN
	DimDepartment AS dd
ON
	fhr.DeptID = dd.DeptID
LEFT JOIN
	DimPosition AS dp
ON
	fhr.PositionID = dp.PositionID
WHERE Department = @department_name
END
	-- Sample Query : EXEC Department 'IT/IS'

-- Find the difference between the previous year and the present employee hire count by year.
WITH CTE as (

SELECT
	YEAR(DateofHire) AS Year,
	COUNT(EmpID) AS TotalHiredEveryYear
FROM
	DimEmployee
GROUP BY
	YEAR(DateofHire)
)
SELECT
	Year,
	ISNULL(LAG(TotalHiredEveryYear) OVER (ORDER BY Year),0) AS PreviousYear,
	TotalHiredEveryYear AS PresentYear,
	TotalHiredEveryYear - ISNULL(LAG(TotalHiredEveryYear) OVER (ORDER BY Year),0) AS DiffChange
FROM 
	CTE
