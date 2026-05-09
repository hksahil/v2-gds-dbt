-- models/intermediate/int_order_items.sql
-- Joins line items with orders to build enriched order-item grain
with orders as (
    select * from {{ ref('stg_orders') }}
),
lineitems as (
    select * from {{ ref('stg_lineitems') }}
),
order_items as (
    select
        o.order_key,
        o.customer_key,
        o.order_date,
        o.order_status,
        o.order_priority,
        o.order_year,
        o.order_month,
        l.line_number,
        l.part_key,
        l.quantity,
        l.extended_price,
        l.discount_pct,
        l.net_revenue,
        l.ship_date,
        l.ship_mode,
        l.return_flag,
        l.days_late
    from orders o
    inner join lineitems l on o.order_key = l.order_key
)
select * from order_items
