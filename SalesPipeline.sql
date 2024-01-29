-----------Creating Table
--Creating Sales Table
CREATE TABLE Sales(
TransactionID INT NOT NULL,
OrderID NVARCHAR(50) NOT NULL,
OrderDate DATE NOT NULL,
ShipDate DATE NOT NULL,
ShipModeID INT NOT NULL,
CustomerID NVARCHAR(50) NOT NULL,
SegmentID INT NOT NULL,
ProdcuctID NVARCHAR(50) NOT NULL,
Quantity INT NOT NULL
)


--Creating Customer Table
CREATE TABLE Customer(
CustomerID NVARCHAR(50) NOT NULL,
CustomerName NVARCHAR(100) NOT NULL,
City NVARCHAR(50) NOT NULL,
State NVARCHAR(50) NOT NULL,
Region NVARCHAR(50) NOT NULL,
Country NVARCHAR(50) NOT NULL,
PostalCode INT NOT NULL
)

--Creating ShipMode Table
CREATE TABLE ShipMode (
ShipModeID INT IDENTITY(1,1) NOT NULL,
ShipMode NVARCHAR(50)
)


--Creating Segment Table
CREATE TABLE Segment(
SegmentID INT IDENTITY(1,1) NOT NULL,
Segment NVARCHAR(50)
)

--Creating Product Table
CREATE TABLE Product(
ProductID NVARCHAR(50) NOT NULL,
ProductName NVARCHAR(250) NOT NULL,
SubCategoryID INT NOT NULL,
Price MONEY
)

--Creating SubCategory Table
CREATE TABLE SubCategory(
SubCategoryID INT IDENTITY(1,1) NOT NULL,
SubCategory NVARCHAR(100) NOT NULL,
CategoryID INT NOT NULL
)
	
	

--Creating Category Table
CREATE TABLE Category (
CategoryID INT IDENTITY(1,1) NOT NULL,
Category NVARCHAR(100) NOT NULL
)

-----------Creating Pipeline
-- Category Pipeline
INSERT INTO Category (Category)
SELECT 
    DISTINCT(s.Category) 
FROM 
    Source AS s
LEFT JOIN 
    Category AS c
ON	
    s.Category = c.Category
WHERE 
    c.Category IS NULL

 --Creating SubCatogery Pipeline
INSERT INTO SubCategory(Subcategory, CategoryID)
SELECT 
    DISTINCT(s.Sub_Category), 
    c.CategoryID 
FROM 
        Source AS s
LEFT JOIN 
    Category as c
ON 
    s.Category = c.Category
LEFT JOIN 
    SubCategory AS sc 
ON
	s.Sub_Category = sc.SubCategory
WHERE 
    sc.SubCategory IS NULL

-- Creating Product Pipeline
INSERT INTO Product(ProductID, ProductName, SubCategoryID, Price)
SELECT
	DISTINCT(s.Product_ID),
	s.Product_Name, 
	sc.SubCategoryID,
	(s.Sales/s.Quantity) AS Price 
FROM 
	Source as s
LEFT JOIN
	SubCategory AS sc
ON 
	s.Sub_Category = sc.SubCategory
LEFT JOIN
	Product AS p
ON
	s.Product_ID = p.ProductID
WHERE p.ProductID IS NULL

-- Creating Segment
INSERT INTO Segment(Segment)
SELECT 
	DISTINCT(s.Segment)
FROM 
	Source AS s
LEFT JOIN
	Segment AS sg
ON
	s.Segment = sg.Segment
WHERE
	sg.Segment IS NULL

-- Creating ShipMode
INSERT INTO ShipMode(ShipMode)
SELECT 
	DISTINCT(s.Ship_Mode)
FROM 
	Source AS s
LEFT JOIN
	ShipMode AS sm
ON
	s.Ship_Mode = sm.ShipMode
WHERE 
	sm.ShipMode IS NULL

 --Creating Customer
INSERT INTO Customer(CustomerID,CustomerName,City,State,Region,Country,PostalCode)
SELECT 
	DISTINCT(s.Customer_ID),
	s.Customer_Name,
	s.City,
	s.State,
	s.Region,
	s.Country,
	s.Postal_Code
FROM 
	Source AS s
LEFT JOIN 
	Customer AS c
ON
	s.Customer_ID =c.CustomerID
WHERE
	c.CustomerID IS NULL

-- Creating Sales
INSERT INTO Sales(TransactionID,OrderID,OrderDate,ShipDate,ShipModeID,CustomerID, SegmentID, ProdcuctID,Quantity)
SELECT 
	s.Transaction_ID,
	s.Order_ID,
	s.Order_Date,
	s.Ship_Date,
	sm.ShipModeID,
	c.CustomerID,
	seg.SegmentID,
	prod.ProductID,
	s.Quantity
FROM 
	Source AS s
LEFT JOIN 
	ShipMode AS sm
ON
	s.Ship_Mode = sm.ShipMode
LEFT JOIN
	Customer AS c
ON
	s.Customer_ID = c.CustomerID
LEFT JOIN
	Segment AS seg
ON
	s.Segment = seg.Segment
LEFT JOIN
	Product AS prod
ON
	s.Product_ID =prod.ProductID
LEFT JOIN
	Sales AS sales
ON
	s.Transaction_ID = sales.TransactionID
WHERE
	sales.TransactionID IS NULL