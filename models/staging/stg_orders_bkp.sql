SELECT
    order_id,
    customer_id,
    order_date,
    product_name,
    quantity,
    unit_price,
    quantity * unit_price AS total_amount,
    status,
    region,
    phone,
    email
FROM prod.prod.orders_v3