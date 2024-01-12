-- 1. Retrieve the first 5 products from the Product table
SELECT 
    TOP 5 *
FROM 
    DimProduct

-- 2.  Get the top 10 employees from the Employee table along with their job titles.
SELECT 
    TOP 10 EmployeeKey, 
    FirstName, 
    MiddleName, 
    LastName, 
    Title
FROM 
    DimEmployee

-- 3. Retrieve all orders placed by customer 'John Smith' (FirstName = 'John' and LastName = 'Smith') from the [dbo]. [FactInternetSales] table.
SELECT
	SalesOrderNumber,
	OrderDate,
	SalesAmount
FROM
	FactInternetSales
WHERE
	CustomerKey
IN(
	SELECT
		CustomerKey
	FROM
		DimCustomer
	WHERE
		FirstName = 'John' AND LastName = 'Smith'
    )































                                                                                                    
