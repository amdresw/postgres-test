-- Listar los productos con stock menor a 5 unidades.

SELECT name, stock
FROM Product
WHERE stock < 5;

 --Calcular ventas totales de un mes específico.

SELECT 
    DATE_TRUNC('month', sale_date) AS mes,
    SUM(total_amount) AS total_ventas
FROM Sale
WHERE sale_date >= '2025-04-01' AND sale_date < '2025-05-01'
GROUP BY mes;

 --Obtener el cliente con más compras realizadas.

SELECT c.name, COUNT(s.id) AS cantidad_compras
FROM Customer c
JOIN Sale s ON s.customer_id = c.id
GROUP BY c.name
ORDER BY cantidad_compras DESC
LIMIT 1;

 --Listar los 5 productos más vendidos.

SELECT p.name, SUM(sd.quantity) AS total_vendido
FROM SaleDetail sd
JOIN Product p ON sd.product_id = p.id
GROUP BY p.name
ORDER BY total_vendido DESC
LIMIT 5;

 --Consultar ventas realizadas en un rango de fechas de tres Días y un Mes.

-- Rango de 3 días
SELECT * 
FROM Sale
WHERE sale_date BETWEEN '2025-04-01' AND '2025-04-03';

-- Rango de 1 mes
SELECT * 
FROM Sale
WHERE sale_date BETWEEN '2025-04-01' AND '2025-04-30';

 --Identificar clientes que no han comprado en los últimos 6 meses.

SELECT c.name
FROM Customer c
WHERE NOT EXISTS (
    SELECT 1
    FROM Sale s
    WHERE s.customer_id = c.id
      AND s.sale_date >= CURRENT_DATE - INTERVAL '6 months'
);
