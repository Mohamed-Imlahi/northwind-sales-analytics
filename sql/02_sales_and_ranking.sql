WITH VentasMesActual AS (

    SELECT o.CustomerID, STRFTIME('%Y-%m', o.OrderDate) AS Orden_mensual,
    COUNT(o.OrderID) AS Cantidad_orden,
    ROUND(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)), 2) AS Venta_Total
    FROM orders o
    INNER JOIN "Order Details" od ON od.OrderID = o.OrderID
    WHERE OrderDate BETWEEN '2023-01-01' AND '2023-12-31'
    GROUP BY o.CustomerID, Orden_mensual
    ORDER BY Venta_Total DESC
),

VentasMesAnterior AS (

    SELECT Orden_mensual, Venta_Total AS Venta_Actual,
    LAG (venta_total) OVER (ORDER BY Orden_mensual ASC) AS Venta_Anterior
    FROM VentasMesActual ),

VentasPorClienteRegion AS (
    SELECT 
        c.Region,
        c.CustomerID,
        c.CompanyName,
        ROUND(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)), 2) AS Venta_Total
    FROM Orders o
    INNER JOIN "Order Details" od ON od.OrderID = o.OrderID
    INNER JOIN Customers c ON c.CustomerID = o.CustomerID
    WHERE c.Region IS NOT NULL 
    GROUP BY c.Region, c.CustomerID, c.CompanyName)


SELECT Venta_Actual, Venta_Anterior, 
ROUND(((Venta_Actual- Venta_Anterior) *100.0/ Venta_Anterior),2) AS Variacion_Percentual
FROM VentasMesAnterior;

--solo se ejecuta un solo select--

SELECT 
    Region,
    CustomerID,
    CompanyName,
    Venta_Total,
    ROW_NUMBER() OVER (
        PARTITION BY Region 
        ORDER BY Venta_Total DESC
    ) AS Posicion_En_Region
FROM VentasPorClienteRegion
ORDER BY Region ASC, Posicion_En_Region ASC;


