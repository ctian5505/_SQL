


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
