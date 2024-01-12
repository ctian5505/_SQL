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

-- 4. Get all products with a weight greater than 10 pounds (Weight > 10) from the [dbo] • [DimProduct] table.
SELECT
	ProductKey, 
	EnglishProductName, 
	Weight, 
	WeightUnitMeasureCode
FROM 
	DimProduct 
WHERE 
	Weight > 10 AND WeightUnitMeasureCode = 'LB'

-- 5. Get the top 5 products with the lowest list prices from the [dbo]-[DimProduct] table.
SELECT 
	TOP 5
	ProductKey,
	EnglishProductName,
	ListPrice 
FROM
	DimProduct
WHERE
	ListPrice IS NOT NULL
ORDER BY
	ListPrice ASC

--6. Retrieve the 10 oldest orders from the [dbo]. [FactInternetSales] table, sorted by the order date in ascending order.
SELECT
	TOP 10 
	SalesOrderNumber,
	ProductKey,
	OrderDate,
	SalesAmount
FROM
	FactInternetSales
ORDER BY 
	OrderDate ASC




























                                                                                                    
