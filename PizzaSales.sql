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
