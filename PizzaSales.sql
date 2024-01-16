----- Create Database
--CREATE DATABASE PizzaSales;
-----------------------------------------------

--- Import the data : - Data Link -https://mavenanalytics.io/data-playground?page=2&pageSize=5
-----------------------------------------------

--- Data type formating
	-- menu_items
	--ALTER TABLE menu_items
	--ALTER COLUMN menu_item_id int not null

	--ALTER TABLE menu_items
	--ALTER COLUMN item_name nvarchar(75)not null

	--ALTER TABLE menu_items
	--ALTER COLUMN category nvarchar(75) not null

	--ALTER TABLE menu_items 
	--ALTER COLUMN price money not null

	-- order_details

--ALTER TABLE order_details
--ALTER COLUMN order_details_id int not null

--ALTER TABLE order_details
--ALTER COLUMN order_id int not null

--ALTER TABLE order_details
--ALTER COLUMN order_date date not null

--ALTER TABLE order_details
--ALTER COLUMN order_time time(0) not null

--ALTER TABLE order_details
--ALTER COLUMN item_id int not null
-----------------------------------------------
--- Removing order with Item id with 'null' value : because it will not connect to the fact table

--DELETE FROM order_details
--WHERE item_id = 'null'
-----------------------------------------------
--- adding constraints
-- PK
--ALTER TABLE menu_items
--ADD CONSTRAINT PK_MenuItems 
--Primary KEY (menu_item_id)
-- FK
--ALTER TABLE order_details
--ADD CONSTRAINT FK_ItemID
--FOREIGN KEY (item_id)
--REFERENCES menu_items(menu_item_id)
-------------------- Queries Random

-- Count the total transaction
--SELECT
--	COUNT(*) AS TransactionCount
--FROM
--	order_details






--Recommended Analysis ( Maven)
-- 1. What were the least and most ordered items? What categories were they in?
--- Most
--SELECT
--	TOP 1
--	item_id,
--	item_name,
--	category,
--	COUNT(order_details_id) AS OrderCount
--FROM
--	order_details AS od
--LEFT JOIN
--	menu_items AS mi
--ON
--	od.item_id = mi.menu_item_id
--GROUP BY
--	item_id,
--	item_name,
--	category
--ORDER BY 
--	OrderCount DESC
	
--- Least
--SELECT
--	TOP 1
--	item_id,
--	item_name,
--	category,
--	COUNT(order_details_id) AS OrderCount
--FROM
--	order_details AS ods
--LEFT JOIN
--	menu_items AS mi
--ON
--	od.item_id = mi.menu_item_id
--GROUP BY
--	item_id,
--	item_name,
--	category
--ORDER BY 
--	OrderCount

-- 2. What do the highest spend orders look like? Which items did they buy and how much did they spend?

--SELECT 
--	od.item_id,
--	mi.item_name,
--	SUM(price) as TotalSale
--FROM
--	order_details AS od
--LEFT JOIN
--	menu_items as mi
--ON
--	od.item_id = mi.menu_item_id
--GROUP BY
--	item_id,
--	mi.item_name
--ORDER BY
--	TotalSale DESC


-- 3. Were there certain times that had more or less orders?
SELECT TOP 10 * FROM order_details
SELECT TOP 10 * FROM menu_items

-- by date

-- By hour

SELECT
	DATEPART(HOUR, order_time) AS Hour,
	SUM(price) AS TotalSales
FROM
	order_details AS od
LEFT JOIN
	menu_items AS mi
ON
	od.item_id = mi.menu_item_id
GROUP BY	
	DATEPART(HOUR, order_time)
ORDER BY
	DATEPART(HOUR, order_time) DESC

-- Month
SELECT
	DATEPART(MONTH, order_date) AS Hour,
	SUM(price) AS TotalSales
FROM
	order_details AS od
LEFT JOIN
	menu_items AS mi
ON
	od.item_id = mi.menu_item_id
GROUP BY	
	DATEPART(MONTH, order_date)
ORDER BY
	DATEPART(MONTH, order_date) DESC

--- Day
SELECT
	DATEPART(DAY, order_date) AS Hour,
	SUM(price) AS TotalSales
FROM
	order_details AS od
LEFT JOIN
	menu_items AS mi
ON
	od.item_id = mi.menu_item_id
GROUP BY	
	DATEPART(DAY, order_date)
ORDER BY
	DATEPART(DAY, order_date) DESC




-- 4. Which cuisines should we focus on developing more menu items for based on the data?


---- To Arrange


----- Create Database
--CREATE DATABASE PizzaSales;
-----------------------------------------------

--- Import the data : - Data Link -https://mavenanalytics.io/data-playground?page=2&pageSize=5
-----------------------------------------------

--- Data type formating
	-- menu_items
	--ALTER TABLE menu_items
	--ALTER COLUMN menu_item_id int not null

	--ALTER TABLE menu_items
	--ALTER COLUMN item_name nvarchar(75)not null

	--ALTER TABLE menu_items
	--ALTER COLUMN category nvarchar(75) not null

	--ALTER TABLE menu_items 
	--ALTER COLUMN price money not null

	-- order_details

--ALTER TABLE order_details
--ALTER COLUMN order_details_id int not null

--ALTER TABLE order_details
--ALTER COLUMN order_id int not null

--ALTER TABLE order_details
--ALTER COLUMN order_date date not null

--ALTER TABLE order_details
--ALTER COLUMN order_time time(0) not null

--ALTER TABLE order_details
--ALTER COLUMN item_id int not null
-----------------------------------------------
--- Removing order with Item id with 'null' value : because it will not connect to the fact table

--DELETE FROM order_details
--WHERE item_id = 'null'
-----------------------------------------------
--- adding constraints
-- PK
--ALTER TABLE menu_items
--ADD CONSTRAINT PK_MenuItems 
--Primary KEY (menu_item_id)
-- FK
--ALTER TABLE order_details
--ADD CONSTRAINT FK_ItemID
--FOREIGN KEY (item_id)
--REFERENCES menu_items(menu_item_id)
-------------------- Queries Random

-- Count the total transaction
--SELECT
--	COUNT(*) AS TransactionCount
--FROM
--	order_details






--Recommended Analysis ( Maven)
-- 1. What were the least and most ordered items? What categories were they in?
--- Most
--SELECT
--	TOP 1
--	item_id,
--	item_name,
--	category,
--	COUNT(order_details_id) AS OrderCount
--FROM
--	order_details AS od
--LEFT JOIN
--	menu_items AS mi
--ON
--	od.item_id = mi.menu_item_id
--GROUP BY
--	item_id,
--	item_name,
--	category
--ORDER BY 
--	OrderCount DESC
	
--- Least
--SELECT
--	TOP 1
--	item_id,
--	item_name,
--	category,
--	COUNT(order_details_id) AS OrderCount
--FROM
--	order_details AS ods
--LEFT JOIN
--	menu_items AS mi
--ON
--	od.item_id = mi.menu_item_id
--GROUP BY
--	item_id,
--	item_name,
--	category
--ORDER BY 
--	OrderCount

-- 2. What do the highest spend orders look like? Which items did they buy and how much did they spend?

--SELECT 
--	od.item_id,
--	mi.item_name,
--	SUM(price) as TotalSale
--FROM
--	order_details AS od
--LEFT JOIN
--	menu_items as mi
--ON
--	od.item_id = mi.menu_item_id
--GROUP BY
--	item_id,
--	mi.item_name
--ORDER BY
--	TotalSale DESC


-- 3. Were there certain times that had more or less orders?

---  hour

--SELECT
--	DATEPART(HOUR, order_time) AS Hour,
--	SUM(price) AS TotalSales
--FROM
--	order_details AS od
--LEFT JOIN
--	menu_items AS mi
--ON
--	od.item_id = mi.menu_item_id
--GROUP BY	
--	DATEPART(HOUR, order_time)
--ORDER BY
--	TotalSales DESC
	

--- Month
--SELECT
--	DATEPART(MONTH, order_date) AS Hour,
--	SUM(price) AS TotalSales
--FROM
--	order_details AS od
--LEFT JOIN
--	menu_items AS mi
--ON
--	od.item_id = mi.menu_item_id
--GROUP BY	
--	DATEPART(MONTH, order_date)
--ORDER BY
--	TotalSales DESC

--- Day
--SELECT
--	DATEPART(DAY, order_date) AS Hour,
--	SUM(price) AS TotalSales
--FROM
--	order_details AS od
--LEFT JOIN
--	menu_items AS mi
--ON
--	od.item_id = mi.menu_item_id
--GROUP BY	
--	DATEPART(DAY, order_date)
--ORDER BY
--	TotalSales DESC

--- Year
--SELECT
--	DATEPART(YEAR, order_date) AS [Year],
--	SUM(price) AS TotalSale
--FROM
--	order_details as od
--LEFT JOIN
--	menu_items as mi
--ON
--	od.item_id = mi.menu_item_id
--GROUP BY
--	DATEPART(YEAR, order_date)




-- 4. Which cuisines should we focus on developing more menu items for based on the data?
--SELECT
--	item_name,
--	category,
--	SUM(price) AS TotalSale,
--	RANK() OVER (ORDER BY SUM(price) DESC) AS Rank
--FROM
--	order_details AS od
--LEFT JOIN
--	menu_items AS mi
--ON
--	od.item_id = mi.menu_item_id
--GROUP BY
--	item_name,
--	category

	
--- Cummulative monthy, Daily , Hourly, Sales

--- Monthly

--WITH 
--	CTEMonthlySales 
--AS
--	(
--	SELECT
--		DATEPART(MONTH, od.order_date) AS [Month],
--		SUM(price) AS MonthlySale
--	FROM
--		order_details AS od
--	LEFT JOIN
--		menu_items AS mi
--	ON
--		od.item_id = mi.menu_item_id
--	GROUP BY
--		DATEPART(MONTH, od.order_date)
--	)
--SELECT 
--	*,
--	SUM(MonthlySale) OVER (ORDER BY Month) AS CummulativeMonthlySales
--FROM
--	CTEMonthlySales


--- Daily
--WITH 
--	CTEDailySales 
--AS
--	(
--	SELECT
--		DATEPART(DAY, order_date) AS [Day],
--		SUM(price) AS DailySales
--	FROM
--		order_details AS od
--	LEFT JOIN
--		menu_items AS mi
--	ON
--		od.item_id = mi.menu_item_id
--	GROUP BY
--		DATEPART(DAY, order_date)
--	)
--SELECT
--	*,
--	SUM(DailySales) OVER (ORDER BY Day ASC) AS CummulativeDailySales
--FROM
--	CTEDailySales


--- Hourly
--WITH
--	CTEHourlySales
--AS
--		(
--	SELECT
--		DATEPART(HOUR, order_time) AS [Hour],
--		SUM(price) AS HourlySales
--	FROM
--		order_details as od
--	LEFT JOIN
--		menu_items as mi
--	ON
--		mi.menu_item_id = od.item_id
--	GROUP BY
--		DATEPART(HOUR, order_time)
--	)
--SELECT
--	*,
--	SUM(HourlySales) OVER (ORDER BY Hour) AS CummlativeHourlySales
--FROM
--	CTEHourlySales

--- Who has the highest purchase
--SELECT
--	od.order_id,
--	SUM(price) SalesByOrderID,
--	RANK() OVER (ORDER BY SUM(price) DESC ) AS Rank
--FROM
--	order_details AS od
--LEFT JOIN
--	menu_items AS mi
--ON
--	od.item_id = mi.menu_item_id
--GROUP BY
--	od.order_id




------- Previous Days in Month january
--WITH
--	CTEJanuarySales
--AS(
--	SELECT
--		DATEPART(DAY, order_date) AS January,
--		SUM(price) AS DailySales
--	FROM
--		order_details AS od
--	LEFT JOIN
--		menu_items AS mi
--	ON
--		od.item_id = mi.menu_item_id
--	WHERE
--		DATEPART(Month, order_date) = 1
--	GROUP BY
--		DATEPART(DAY, order_date)
--	)
--SELECT
--	*,
--	ISNULL(LAG(DailySales) OVER (ORDER BY January), 0 ) AS PreviousDaySale,
--	DailySales - ISNULL(LAG(DailySales) OVER (ORDER BY January), DailySales ) AS DayChange
--FROM
--	CTEJanuarySsales

-- Display the item name together its cataegory and count parttion by the category

--SELECT
--	item_name, 
--	category,
--	COUNT(category) OVER (PARTITION BY category) AS CategoryCount
--FROM
--	menu_items

--SELECT
--	DISTINCT(mi.menu_item_id), 
--	mi.item_name, 
--	mi.category, 
--	SUM(price) OVER (PARTITION BY category)
--FROM
--	order_details AS od
--LEFT JOIN
--	menu_items AS mi
--ON
--	od.item_id = mi.menu_item_id
--ORDER BY
--	category








SELECT
	TOP 10 *
FROM
	order_details

SELECT
	TOP 10 *
FROM
	menu_items

