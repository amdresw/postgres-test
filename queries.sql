-- Listar los productos con stock menor a 5 unidades.

SELECT id,name, category_id, price, stock, provider_id FROM Product WHERE stock < 5;

 --Calcular ventas totales de un mes específico.

SELECT SUM(total_amount) FROM Sale WHERE sale_date BETWEEN '2025-04-01' AND '2025-04-30';

 --Obtener el cliente con más compras realizadas.

SELECT Customer.id, COUNT(*) as total_compras FROM ventas GROUP BY cliente_id ORDER BY total_compras DESC LIMIT 1;

 --Listar los 5 productos más vendidos.

SELECT producto_id, COUNT(*) as total_ventas FROM ventas GROUP BY producto_id ORDER BY total_ventas DESC LIMIT 5;

 --Consultar ventas realizadas en un rango de fechas de tres Días y un Mes.

SELECT * FROM ventas WHERE fecha_venta BETWEEN '2023-01-01' AND '2023-02-01';

 --Identificar clientes que no han comprado en los últimos 6 meses.

SELECT cliente_id FROM ventas WHERE fecha_venta < DATE_SUB(CURDATE(), INTERVAL 6 MONTH) GROUP BY cliente_id;