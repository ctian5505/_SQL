-- Datasets : https://drive.google.com/file/d/15Jko-HW6HSDAcWCEoKUdZC9wSghxjk9M/view?usp=sharing

-- I created a stored procedure that, when executed, will automatically transfer the data into its designated table from raw data. This stored procedure will also not input duplicate values. This is just the first version of the stored procedure; more improvements will come.

-- This data is connected to Microsoft PowerBI and is still under construction.

-- Steps if you want to try it 

-- Here are the steps if you want to try it.
	-- Download the dataset
	-- Create a Database on MSSQL Server with a name of SalesDB (Code Below)
	-- Import the CSV data into SalesDB
	-- Create table (Code Below)
	-- Add Constraint | Primary key & Foreign Key | (Code Below)
	-- Create the Stored Procedure (Code Below)
		-- This stored procedure will create a temporary table based on the data that we import, then it will check if there are new unique entries, and it will transfer those new data into its designated table. After that, the temporary table will be deleted.
	-- Executed the Stored Procedure by Querying "EXEC  Test"
	-- After that, you can drop the table that we imported (SuperSale), and if we want to import new data, just import the data set and query "EXEC Test" and repeat.



-- Creating Database
CREATE DATABASE SalesDB

--Creating Table
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

-- Adding Constraint
	-- Adding Primary Key Constrain on Customer..CustomerID
ALTER TABLE Customer
ADD CONSTRAINT PK_CustomerID
PRIMARY KEY(CustomerID)
	
	-- Adding Primary Key Constrain on ShipMode..ShipModeID
ALTER TABLE ShipMode
ADD CONSTRAINT PK_ShipModeID
PRIMARY KEY(ShipModeID)

	-- Adding Primary Key Constrain on Segment..SegmentID
ALTER TABLE Segment
ADD CONSTRAINT PK_SegmentID
PRIMARY KEY(SegmentID)

	-- Adding Primary Key Constrain on Product..ProductID
ALTER TABLE Product
ADD CONSTRAINT PK_ProductID
PRIMARY KEY(ProductID)

	-- Adding Primary Key Constrain on SubCategory..SubCategoryID
ALTER TABLE SubCategory
ADD CONSTRAINT PK_SubCategoryID
PRIMARY KEY(SubCategoryID)

	-- Adding Primary Key Constrain on Category..CategoryID
ALTER TABLE Category
ADD CONSTRAINT PK_CategoryID
PRIMARY KEY(CategoryID)

	-- Adding Foreign Key Constrain on SubCategory..CategoryID
ALTER TABLE SubCategory
ADD CONSTRAINT FK_CategoryKey
FOREIGN KEY(CategoryID)
REFERENCES Category(CategoryID)

	-- Adding Foreign Key Constrain on Product..SubCategoryID
ALTER TABLE Product
ADD CONSTRAINT FK_SubCategoryID
FOREIGN KEY (SubCategoryID)
REFERENCES SubCategory(SubCategoryID)

	-- Adding Foreign Key Constrain on Sales..ProductID
ALTER TABLE Sales
ADD CONSTRAINT FK_ProductID
FOREIGN KEY(ProductID) 
REFERENCES Product(ProductID)	
	
	-- Adding Foreign Key Constrain on Sales..SegmentID
ALTER TABLE Sales
ADD CONSTRAINT FK_SegmentID
FOREIGN KEY(SegmentID)
REFERENCES Segment(SegmentID)

	-- Adding Foreign Key Constrain on ShipMode..FK_ShipmodeID
ALTER TABLE Sales
ADD CONSTRAINT FK_ShipmodeID
FOREIGN KEY(ShipModeID)
REFERENCES ShipMode(ShipModeID)

	-- Adding Foreign Key Constrain on Sales..CustomerID
ALTER TABLE Sales
ADD CONSTRAINT FK_CustomerID
FOREIGN KEY(CustomerID)
REFERENCES Customer(CustomerID)
	
--Stored Procedure (ETL)
CREATE PROCEDURE Test
AS
BEGIN
	-- Droping Temporary Table if Existed
	DROP TABLE #TempTable
	-- Creating Temporary Table
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

	-- Inserting into Category
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

	-- Inserting into SubCatogery
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

	-- Inserting into Product
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

	-- Inserting into Segment
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

	-- Inserting into ShipMode
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

	--Inserting into Customer
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

	-- Inserting into Sales
	INSERT INTO Sales(TransactionID,OrderID,OrderDate,ShipDate,ShipModeID,CustomerID, SegmentID, ProductID,Quantity)
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
		#TempTable AS s
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
