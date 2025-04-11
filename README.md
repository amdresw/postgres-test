# 🛒 TechZone Inventory & Sales Management System

Este proyecto implementa una base de datos relacional en **PostgreSQL** para la gestión de inventario, ventas, clientes y proveedores de una tienda de tecnología ficticia llamada **TechZone**. La solución aborda los principales problemas administrativos y de control que enfrentaba la tienda al utilizar hojas de cálculo manuales.

---

## 📚 Tabla de contenidos

- [Objetivos del sistema](#objetivos-del-sistema)
- [Modelo de datos](#modelo-de-datos)
- [Tecnologías utilizadas](#tecnologías-utilizadas)
- [Entidades y relaciones](#entidades-y-relaciones)
- [Consultas importantes](#consultas-importantes)
- [Procedimientos y funciones](#procedimientos-y-funciones)
- [Fechas y datos usados](#fechas-y-datos-usados)
- [Autor](#autor)

---

## 🎯 Objetivos del sistema

- Gestionar eficientemente productos y su inventario.
- Automatizar el registro de ventas y actualizar el stock.
- Controlar a los clientes y sus compras.
- Llevar registro de los proveedores y productos que suministran.
- Obtener reportes de rendimiento (productos más vendidos, clientes frecuentes, ingresos por mes, etc.).

---

## 🧰 Tecnologías utilizadas

- **PostgreSQL 15+**
- **PL/pgSQL** (lenguaje de procedimientos para funciones y triggers)
- Herramientas opcionales: DBeaver, StarUML.

---

## 🗃️ Modelo de datos

El diseño sigue principios de **normalización (3FN)** para garantizar integridad y escalabilidad.

### Tablas principales:

- `Product`: información de productos tecnológicos.
- `Customer`: datos de los clientes.
- `Provider`: proveedores asociados.
- `Sale`: encabezado de la venta (cliente, fecha, total).
- `SaleDetail`: detalle de cada producto vendido.
- `Category`: clasificaciones de productos.


---


## 📌 Consultas importantes implementadas

- Productos con **stock menor a 5** unidades.
- **Ventas totales** por mes o por rango de fechas.
- **Cliente con más compras** realizadas.
- Top **5 productos más vendidos**.
- Clientes que **no han comprado en los últimos 6 meses**.
- Historial de ventas **en un rango de días y meses**.

---

🗓️ Fechas y datos usados
Las ventas se generaron con fechas dentro del rango abril 1 a abril 9 del año 2025, para facilitar el análisis por mes y día:

2025-04-01 10:00:00

2025-04-03 15:30:00

2025-04-05 09:20:00

2025-04-07 14:10:00

2025-04-09 10:15:00

Se insertaron 10 productos, 5 proveedores, 5 categorías y múltiples combinaciones cliente/venta.

---
## ⚙️ Procedimientos y funciones

### `registrar_venta(customer_id, sale_date, product_ids[], quantities[])`

Procedimiento almacenado para registrar una venta completa:

- ✅ Valida que el cliente exista.
- ✅ Verifica stock de cada producto.
- ✅ Registra venta y detalles.
- ✅ Descuenta stock de productos.
- ⚠️ Si no hay stock suficiente, muestra error con `RAISE EXCEPTION`.

Ejemplo de uso:

```sql
CALL registrar_venta(
    1,
    NOW(),
    ARRAY[2, 3],
    ARRAY[1, 2]
);




