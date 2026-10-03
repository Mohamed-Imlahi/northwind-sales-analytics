
--Subconsulta WHERE Chang--

SELECT ProductName, UnitPrice, CategoryID
FROM Products
WHERE CategoryID= 
(SELECT CategoryID
FROM Products
WHERE ProductName= 'Chang');

--Subconsulta WHERE Around the Horn--
SELECT CompanyName, ContactName, City
FROM Customers
WHERE City= 
(SELECT City
FROM Customers
WHERE CompanyName= 'Around the Horn');

--Subconsulta IN--
SELECT CustomerID, CompanyName, Country
FROM Customers
WHERE Country IN 
(SELECT Country 
FROM Employees)
LIMIT 10;

--Subconsulta EXISTS--
SELECT CategoryName, Description, CategoryID
FROM Categories c
WHERE EXISTS 
(SELECT 1
FROM Products p
WHERE p.CategoryID= c.CategoryID AND p.Discontinued= 0);

--  WHERE NOT EXISTS con Auditoría de Clientes Inactivos--
SELECT c.CustomerID, c.CompanyName, c.ContactName, c.Country 
FROM Customers c
WHERE NOT EXISTS (
    SELECT 1 
    FROM Orders o 
    WHERE o.CustomerID = c.CustomerID);





