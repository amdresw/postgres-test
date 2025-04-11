--Un procedimiento almacenado para registrar una venta.
CREATE OR REPLACE PROCEDURE registrar_venta(
    p_customer_id INTEGER,
    p_sale_date TIMESTAMP,
    p_product_ids INTEGER[],
    p_quantities INTEGER[]
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_total NUMERIC := 0;
    v_unit_price NUMERIC;
    v_stock INTEGER;
    v_sale_id INTEGER;
    i INTEGER := 1;
BEGIN
    -- Validar existencia del cliente
    IF NOT EXISTS (SELECT 1 FROM Customer WHERE id = p_customer_id) THEN
        RAISE EXCEPTION 'Cliente con ID % no existe.', p_customer_id;
    END IF;

    -- Validar que las longitudes coincidan
    IF array_length(p_product_ids, 1) != array_length(p_quantities, 1) THEN
        RAISE EXCEPTION 'Cantidad de productos y cantidades no coinciden.';
    END IF;

    -- Verificar stock de todos los productos
    FOREACH i IN ARRAY generate_subscripts(p_product_ids, 1)
    LOOP
        SELECT stock, price INTO v_stock, v_unit_price
        FROM Product
        WHERE id = p_product_ids[i];
        --Si no hay stock suficiente, Notificar por medio de un mensaje en consola usando RAISE.
        IF NOT FOUND THEN
            RAISE EXCEPTION 'Producto con ID % no existe.', p_product_ids[i];
        END IF;

        IF v_stock < p_quantities[i] THEN
            RAISE EXCEPTION 'Stock insuficiente para el producto ID % (Disponible: %, Solicitado: %).',
                p_product_ids[i], v_stock, p_quantities[i];
        END IF;

        -- Acumular total
        v_total := v_total + (v_unit_price * p_quantities[i]);
    END LOOP;

    -- Insertar venta
    INSERT INTO Sale (customer_id, sale_date, total_amount)
    VALUES (p_customer_id, p_sale_date, v_total)
    RETURNING id INTO v_sale_id;

    -- Insertar detalles y actualizar stock
    FOREACH i IN ARRAY generate_subscripts(p_product_ids, 1)
    LOOP
        SELECT price INTO v_unit_price FROM Product WHERE id = p_product_ids[i];

        INSERT INTO SaleDetail (sale_id, product_id, quantity, unit_price)
        VALUES (v_sale_id, p_product_ids[i], p_quantities[i], v_unit_price);

        UPDATE Product
        SET stock = stock - p_quantities[i]
        WHERE id = p_product_ids[i];
    END LOOP;

    RAISE NOTICE 'Venta registrada exitosamente. ID de venta: %', v_sale_id;
END;
$$;







