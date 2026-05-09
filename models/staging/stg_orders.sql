-- models/staging/stg_orders.sql
with source as (
    select * from {{ source('tpch', 'ORDERS') }}
),
renamed as (
    select
        O_ORDERKEY          as order_key,
        O_CUSTKEY           as customer_key,
        O_ORDERSTATUS       as order_status,
        O_TOTALPRICE        as order_total_price,
        O_ORDERDATE         as order_date,
        O_ORDERPRIORITY     as order_priority,
        O_CLERK             as clerk_name,
        O_SHIPPRIORITY      as ship_priority,
        O_COMMENT           as order_comment,
        -- derived
        year(O_ORDERDATE)   as order_year,
        month(O_ORDERDATE)  as order_month
    from source
)
select * from renamed