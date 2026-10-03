

--CATALOGO UNIFICADO DE PRODUCTOS--
SELECT  p.ProductID, p.ProductName,  
s.CompanyName, c.CategoryName, p.UnitPrice
FROM Products p
INNER JOIN Suppliers s ON s.SupplierID= p.SupplierID
INNER JOIN Categories c ON c.CategoryID= p.CategoryID
WHERE p.Discontinued= 0
ORDER BY p.UnitPrice DESC
LIMIT 10;

-- Auditoría de Clientes Inactivos--

SELECT c.CustomerID, c.CompanyName, 
c.ContactName, 
c.Country 
FROM Customers c
LEFT JOIN Orders o ON o.CustomerID= c.CustomerID
WHERE o.CustomerID IS NULL;

--Rendimiento Comercial y Facturación--

SELECT  e.EmployeeID,e.FirstName || ' '|| e.LastName AS NOmbre_completo,
 COUNT(DISTINCT o.OrderID) 
AS total_pedidos, 
ROUND(SUM( DISTINCT od.Quantity * od.UnitPrice * (1-od.Discount)),2) 
AS Facturacion_Total
From Employees e
LEFT JOIN Orders o ON o.EmployeeID= e.EmployeeID
LEFT JOIN "Order Details" od ON od.OrderID= o.OrderID
GROUP BY e.EmployeeID, e.FirstName, e.LastName
ORDER BY Facturacion_Total DESC
LIMIT 10;







