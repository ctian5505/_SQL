-- 1. Retrieve the first 5 products from the Product table.
-- 2. Get the top 10 employees from the Employee table along with their job titles.
-- 3. Retrieve all orders placed by customer 'John Smith' (FirstName = 'John' and LastName = 'Smith') from the [dbo]. [FactInternetSales] table.
-- 4. Get all products with a weight greater than 10 pounds (Weight > 10) from the [dbo] • [DimProduct] table.
-- 5. Get the top 5 products with the lowest list prices from the [dbo]-[DimProduct] table.
-- 6. Retrieve the 10 oldest orders from the [dbo]. [FactInternetSales] table, sorted by the order date in ascending order.
-- 7. Get the 6th to 10th products with the highest list prices from the [dbo]. [DimProduct] table.
-- 8. Retrieve orders placed on or after January 1, 2014, and display results from the 11th row onward using OFFSET-FETCH
-- 9. Insert a new product with the following details into the [dbo] - [DimProduct] table
-- 10. Update the job Title of the employee with EmployeelD 101 in the [dbo] • [DimEmployee] table to 'Software Engineer.'
-- 11. Retrieve all products that have been ordered by customer 'John Smith' (FirstName = John' and LastName = Smith').
-- 12. Retrieve all orders along with customer details for orders placed on or after January 1, 2014, from the dbo.FactinternetSales and dimCustomer tables.
-- 13. Calculate the total sales amount for each product category from the dbo. DimProduct and dbo. FactInternetSales tables. Display the results with the category name, subcategory name and the total sales amount order by cat
-- 14. Retrieve the top 5 customers with the highest total purchases from the [dbo]. [DimCustomer] and [dbo] • [FactInternetSales] tables. Display customer details along with their total
-- 15. Find the average quantity and total sales amount of products sold in each month of the year 2011 from the [dbo]. [DimProduct] and [dbo]. FactResellerSales tables.


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

-- 6. Retrieve the 10 oldest orders from the [dbo]. [FactInternetSales] table, sorted by the order date in ascending order.
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


-- 7. Get the 6th to 10th products with the highest list prices from the [dbo]. [DimProduct] table.
SELECT
	ProductKey, 
	EnglishProductName,
	ListPrice
FROM
	DimProduct
ORDER BY
	ListPrice DESC
OFFSET 5 ROW FETCH NEXT 5 ROW ONLY

-- 8. Retrieve orders placed on or after January 1, 2014, and display results from the 11th row onward using OFFSET-FETCH
SELECT
	SalesOrderNumber,
	ProductKey,
	SalesAmount,
	OrderDate
FROM
	FactInternetSales
WHERE
	OrderDate = '2014-01-01'
ORDER BY 
	SalesOrderNumber ASC
OFFSET 10 ROW

-- 9. Insert a new product with the following details into the [dbo] - [DimProduct] table:
--ProductID: 9999
--EnglishProductName : DSA Training'
--Color: Gold'
--Size: 'XXL"
--ListPrice: 49.99
-- SpanishProductName, FrenchProductName, FinishedGoodsFlag just add some data because this 3 is not allowing null values.

SET IDENTITY_INSERT DimProduct ON

INSERT INTO 
	DimProduct(ProductKey, 
	EnglishProductName,
	Color, 
	Size, 
	ListPrice,
	SpanishProductName,
	FrenchProductName,
	FinishedGoodsFlag)
VALUES(
	9999, 'DSA Training', 'Gold', 'XXL', 49.99,' ',' ',' ')

SET IDENTITY_INSERT DimProduct OFF

-- 10. Update the job Title of the employee with EmployeelD 101 in the [dbo] • [DimEmployee] table to 'Software Engineer.'
UPDATE 
	DimEmployee
SET 
	Title = 'Software Engineer'
WHERE 
	EmployeeKey = 101


-- 11. Retrieve all products that have been ordered by customer 'John Smith' (FirstName = John' and LastName = Smith').
SELECT 
	ProductKey,
	EnglishProductName,
	Color,
	Size
FROM 
	DimProduct
WHERE
	ProductKey
IN(
	SELECT 
		ProductKey
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
	)

-- 12. Retrieve all orders along with customer details for orders placed on or after January 1, 2014, from the dbo.FactinternetSales and dimCustomer tables.
SELECT
	FIS.SalesOrderNumber, 
	FIS.OrderDate, 
	DC.FirstName, 
	DC.LastName, 
	DC.EmailAddress,
	FIS.OrderDate
FROM
	FactInternetSales AS FIS
JOIN
	DimCustomer AS DC
ON
	FIS.CustomerKey = DC.CustomerKey
WHERE
	FIS.OrderDate >= '2014-01-01'

-- 13. Calculate the total sales amount for each product category from the dbo. DimProduct and dbo. FactInternetSales tables. Display the results with the category name, subcategory name and the total sales amount order by category name.
SELECT
	dpc.EnglishProductCategoryName AS [Product Name], 
	dps.EnglishProductSubcategoryName AS [Subcategory Name] , 
	SUM(fis.SalesAmount) AS [Total Sales]
FROM
	FactInternetSales AS fis
LEFT JOIN
	DimProduct AS dp
ON  
	fis.ProductKey = dp.ProductKey
LEFT JOIN
	DimProductSubcategory AS dps
ON
	dp.ProductSubcategoryKey = dps.ProductSubcategoryKey
LEFT JOIN
	DimProductCategory AS dpc
ON
	dps.ProductCategoryKey = dpc.ProductCategoryKey
GROUP BY
	dpc.EnglishProductCategoryName, 
	dps.EnglishProductSubcategoryName

-- 14. Retrieve the top 5 customers with the highest total purchases from the [dbo]. [DimCustomer] and [dbo] • [FactInternetSales] tables. Display customer details along with their total purchases.
SELECT
	TOP 5 dc.FirstName, 
	dc.LastName, 
	dc.EmailAddress, 
	SUM(fis.SalesAmount)
FROM
	FactInternetSales AS fis
LEFT JOIN
	DimCustomer AS dc
ON
	fis.CustomerKey = dc.CustomerKey
GROUP BY
	dc.FirstName, 
	dc.LastName, 
	dc.EmailAddress
ORDER BY
	SUM(fis.SalesAmount) DESC

-- 15. Find the average quantity and total sales amount of products sold in each month of the year 2011 from the [dbo]. [DimProduct] and [dbo]. FactResellerSales tables.
SELECT
	MONTH(OrderDate) AS Month, 
	AVG(fis.OrderQuantity) AS [Order Quantity], 
	SUM(fis.SalesAmount) AS [Sales Amount]
FROM
	FactInternetSales AS fis
LEFT JOIN
	DimProduct AS dp
ON
	fis.ProductKey = dp.ProductKey
WHERE
	YEAR(OrderDate) = 2011
GROUP BY 
	MONTH(OrderDate)
ORDER BY
	MONTH(OrderDate)



















                                                                                                    
