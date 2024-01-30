-- Datasets

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
ProductID NVARCHAR(50) NOT NULL,
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

---------- Adding Constraint
--- Adding Primary Key Constrain on Customer..CustomerID
ALTER TABLE Customer
ADD CONSTRAINT PK_CustomerID
PRIMARY KEY(CustomerID)

--- Adding Primary Key Constrain on ShipMode..ShipModeID
ALTER TABLE ShipMode
ADD CONSTRAINT PK_ShipModeID
PRIMARY KEY(ShipModeID)

--- Adding Primary Key Constrain on Segment..SegmentID
ALTER TABLE Segment
ADD CONSTRAINT PK_SegmentID
PRIMARY KEY(SegmentID)

--- Adding Primary Key Constrain on Product..ProductID
ALTER TABLE Product
ADD CONSTRAINT PK_ProductID
PRIMARY KEY(ProductID)

--- Adding Primary Key Constrain on SubCategory..SubCategoryID
ALTER TABLE SubCategory
ADD CONSTRAINT PK_SubCategoryID
PRIMARY KEY(SubCategoryID)

--- Adding Primary Key Constrain on Category..CategoryID
ALTER TABLE Category
ADD CONSTRAINT PK_CategoryID
PRIMARY KEY(CategoryID)

--- Adding Foreign Key Constrain on SubCategory..CategoryID
ALTER TABLE SubCategory
ADD CONSTRAINT FK_CategoryKey
FOREIGN KEY(CategoryID)
REFERENCES Category(CategoryID)

--- Adding Foreign Key Constrain on Product..SubCategoryID
ALTER TABLE Product
ADD CONSTRAINT FK_SubCategoryID
FOREIGN KEY (SubCategoryID)
REFERENCES SubCategory(SubCategoryID)

--- Adding Foreign Key Constrain on Sales..ProductID
ALTER TABLE Sales
ADD CONSTRAINT FK_ProductID
FOREIGN KEY(ProductID) 
REFERENCES Product(ProductID)	
	
--- Adding Foreign Key Constrain on Sales..SegmentID
ALTER TABLE Sales
ADD CONSTRAINT FK_SegmentID
FOREIGN KEY(SegmentID)
REFERENCES Segment(SegmentID)

--- Adding Foreign Key Constrain on ShipMode..FK_ShipmodeID
ALTER TABLE ShipMode
ADD CONSTRAINT FK_ShipmodeID
FOREIGN KEY(ShipModeID)
REFERENCES ShipMode(ShipModeID)

--- Adding Foreign Key Constrain on Sales..CustomerID
ALTER TABLE Sales
ADD CONSTRAINT FK_CustomerID
FOREIGN KEY(CustomerID)
REFERENCES Customer(CustomerID)
	
-------------Creating Pipeline
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

--SELECT *  FROM Category

-- --Creating SubCatogery Pipeline
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

--SELECT * FROM SubCategory

---- Creating Product Pipeline
INSERT INTO Product(ProductID, ProductName, SubCategoryID, Price)
SELECT
	DISTINCT(s.Product_ID),
	s.Product_Name, 
	sc.SubCategoryID,
	s.Price 
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

--SELECT * FROM Product
---- Creating Segment
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

--SELECT * FROM Segment
---- Creating ShipMode
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

--SELECT * FROM ShipMode

-- --Creating Customer
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

--SELECT * FROM Customer

---- Creating Sales
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

--SELECT * FROM Sales

-----------
Practice Pipeline

CREATE PROCEDURE Test
AS
BEGIN
	--- Droping Temporary Table if Existed
	DROP TABLE #TempTable
	--- Creating Temporary Table
	CREATE TABLE #TempTable(
	Transaction_ID INT NOT NULL,
	Order_ID NVARCHAR(50) NOT NULL,
	Order_Date DATE NOT NULL,
	Ship_Date DATE NOT NULL,
	Ship_Mode NVARCHAR(50) NOT NULL,
	Customer_ID NVARCHAR(50) NOT NULL,
	Customer_Name NVARCHAR(100) NOT NULL,
	Segment NVARCHAR(50) NOT NULL,
	Country NVARCHAR(50) NOT NULL,
	City NVARCHAR(50) NOT NULL,
	State NVARCHAR(50) NOT NULL,
	Postal_Code INT NOT NULL,
	Region NVARCHAR(50) NOT NULL,
	Product_ID NVARCHAR(50) NOT NULL,
	Category NVARCHAR(100) NOT NULL,
	Sub_Category NVARCHAR(100) NOT NULL,
	Product_Name NVARCHAR(250) NOT NULL,
	Price MONEY NOT NULL,
	Sales MONEY NOT NULL,
	Quantity INT NOT NULL,
	)

	INSERT INTO #TempTable(
		Transaction_ID,
		Order_ID,
		Order_Date,
		Ship_Date,
		Ship_Mode,
		Customer_ID,
		Customer_Name,
		Segment,
		Country,
		City,
		State,
		Postal_Code,
		Region,
		Product_ID,
		Category,
		Sub_Category,
		Product_Name,
		Price,
		Sales,
		Quantity)
	SELECT * FROM Superstore

	-- Inserting into Category (Pipeline)
	INSERT INTO Category (
		Category
		)
	SELECT 
		DISTINCT(s.Category) 
	FROM 
		#TempTable AS s
	LEFT JOIN 
		Category AS c
	ON	
		s.Category = c.Category
	WHERE 
		c.Category IS NULL

	--Inserting into SubCatogery (Pipeline)
	INSERT INTO SubCategory(
		Subcategory, 
		CategoryID
		)
	SELECT 
		DISTINCT(s.Sub_Category), 
		c.CategoryID 
	FROM 
			#TempTable AS s
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

	--Inserting into Product (Pipeline)
	INSERT INTO Product(
		ProductID, 
		ProductName, 
		SubCategoryID, 
		Price
		)
	SELECT
		DISTINCT(s.Product_ID),
		s.Product_Name, 
		sc.SubCategoryID,
		s.Price 
	FROM 
		#TempTable as s
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
	INSERT INTO Segment(
		Segment
		)
	SELECT 
		DISTINCT(s.Segment)
	FROM 
		#TempTable AS s
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
		#TempTable AS s
	LEFT JOIN
		ShipMode AS sm
	ON
		s.Ship_Mode = sm.ShipMode
	WHERE 
		sm.ShipMode IS NULL

	--Creating Customer
	INSERT INTO Customer(
		CustomerID,
		CustomerName,
		City,State,
		Region,
		Country,
		PostalCode)
	SELECT 
		DISTINCT(s.Customer_ID),
		s.Customer_Name,
		s.City,
		s.State,
		s.Region,
		s.Country,
		s.Postal_Code
	FROM 
		#TempTable AS s
	LEFT JOIN 
		Customer AS c
	ON
		s.Customer_ID = c.CustomerID
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

	--- Droping Temporary Table
	DROP TABLE #TempTable
END
