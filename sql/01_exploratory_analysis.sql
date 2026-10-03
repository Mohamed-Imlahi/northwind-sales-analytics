-- PREGUNTA 1: LOGÍSTICA DE ENVÍO
SELECT 
    ShipCountry, 
    COUNT(*) AS Total_Envios, 
    ROUND(SUM(Freight), 2) AS Gastos_Logisticos
FROM Orders
GROUP BY ShipCountry
ORDER BY Gastos_Logisticos DESC 
LIMIT 5;

-- PREGUNTA 2: RIESGO CRÍTICO DE ROTURA DE STOCK
SELECT 
    ProductName, 
    UnitsInStock, 
    ReorderLevel,
    UnitsOnOrder,
    (ReorderLevel - UnitsInStock) AS Unidades_A_Pedir
FROM Products
WHERE Discontinued = 0 
  AND UnitsInStock <= ReorderLevel
  AND UnitsOnOrder = 0
ORDER BY UnitsInStock ASC
LIMIT 5;


-- PREGUNTA 3: RENDIMIENTO DEL EQUIPO COMERCIAL
SELECT 
    EmployeeID, 
    COUNT(*) AS Rendimiento_Individual
FROM Orders
GROUP BY EmployeeID
ORDER BY Rendimiento_Individual DESC;