-- DQL(Data Query Language)
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
