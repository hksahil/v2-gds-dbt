with source as (
select * from {{source('tpch','orders')}}
),

renamed as (
    select 
    o_orderkey as order_key,
    o_custkey as customer_key,
    o_orderstatus as order_status,
    o_totalprice as order_total_price,
    o_orderdate as order_date,
    o_orderpriority as order_priority,
    o_clerk as clerk_name,
    o_shippriority as ship_priority,
    o_comment as order_comment,
    year(o_orderdate) as order_year,
    month(o_orderdate) as order_month,
from source
)

select * from renamed