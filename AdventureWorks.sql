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
