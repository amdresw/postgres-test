INSERT INTO Category (name) VALUES
('Laptops'),
('Teléfonos'),
('Accesorios'),
('Componentes'),
('Tablets'),
('Monitores'),
('Almacenamiento'),
('Impresoras'),
('Redes'),
('Periféricos');

INSERT INTO Provider (name, email, phone) VALUES
('TechGlobal S.A.', 'contacto@techglobal.com', '3111234567'),
('ElectroWorld Ltda.', 'ventas@electroworld.com', '3129876543'),
('DigitalZone Corp.', 'info@digitalzone.com', '3104567890'),
('CompuTech S.A.S.', 'support@computech.com', '3161112233'),
('GigaProveedores', 'admin@gigaproveedores.com', '3156667788'),
('NetSolutions', 'proveedor@netsolutions.com', '3143332244'),
('Bytes&Chips', 'comercial@bytesychips.com', '3139871234'),
('MegaStore', 'servicio@megastore.com', '3123344556'),
('ComponentesPro', 'ventas@componentespro.com', '3175556667'),
('AccesoriosYA', 'atencion@accesoriosya.com', '3182233445');

INSERT INTO Product (name, category_id, price, stock, provider_id) VALUES
('Laptop HP 14"', 1, 2500000, 15, 1),
('iPhone 13', 2, 4500000, 10, 2),
('Mouse Logitech', 3, 85000, 50, 10),
('Teclado Mecánico Redragon', 3, 180000, 30, 10),
('Disco SSD 1TB Samsung', 7, 320000, 20, 3),
('Router TP-Link', 9, 150000, 18, 6),
('Monitor LG 24"', 6, 620000, 12, 5),
('Impresora HP DeskJet', 8, 380000, 10, 4),
('Memoria RAM 16GB DDR4', 4, 250000, 25, 9),
('Tablet Samsung Galaxy Tab A8', 5, 980000, 8, 2),
('Laptop ASUS TUF 14"', 1, 3200000, 4, 1),
('Redmi Note 13 Pro + 5g', 2, 1450000, 2, 2),
('Audifonos JBL pro', 3, 390000, 1, 10);

INSERT INTO Customer (name, email, phone) VALUES
('Carlos Pérez', 'cperez@email.com', '3011234567'),
('Laura Gómez', 'lauragomez@email.com', '3027654321'),
('Andrés Ramírez', 'andres.ramirez@email.com', '3039876543'),
('Juliana Torres', 'jtorres@email.com', '3041112233'),
('Luis Castaño', 'lcastano@email.com', '3053334455'),
('Camila Duarte', 'camilad@email.com', '3066667788'),
('Felipe Martínez', 'fmartinez@email.com', '3075556677'),
('Natalia Mora', 'nmora@email.com', '3088889999'),
('Jorge Silva', 'jsilva@email.com', '3094445566'),
('Andrea Ríos', 'andrea.rios@email.com', '3001122334'),
('Andres Araque', 'A_A@gmail.com', '3103339677');

INSERT INTO Sale (customer_id, sale_date) VALUES
(1, '2025-04-01 10:00:00'),
(2, '2025-04-02 15:30:00'),
(3, '2025-04-03 12:45:00'),
(4, '2025-04-04 09:20:00'),
(5, '2025-04-04 17:50:00'),
(6, '2025-04-05 14:00:00'),
(7, '2025-04-05 18:30:00'),
(8, '2025-04-06 11:10:00'),
(9, '2025-04-06 16:40:00'),
(10, '2025-04-07 13:25:00'),
(1, '2025-03-07 19:00:00'),
(1, '2025-02-07 19:00:00'),
(1, '2025-01-07 19:00:00');

INSERT INTO SaleDetail (sale_id, product_id, quantity, unit_price) VALUES
(1, 1, 1, 2500000),
(1, 3, 2, 85000),
(2, 2, 1, 4500000),
(3, 5, 2, 320000),
(4, 4, 1, 180000),
(5, 6, 1, 150000),
(6, 7, 1, 620000),
(7, 8, 1, 380000),
(8, 9, 2, 250000),
(9, 10, 1, 980000),
(10, 7, 4, 620000),
(11, 1, 3, 2500000),
(12, 1, 2, 2500000),
(13, 3, 2, 85000);

--actualizar todas las ventas (una vez hayas realizado la inserción de datos, tambien se podría crear un trigger a futuro). 
UPDATE Sale
SET total_amount = (
    SELECT SUM(sd.unit_price * sd.quantity)
    FROM SaleDetail sd
    WHERE sd.sale_id = Sale.id
);
