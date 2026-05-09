with source as (
select * from {{source('tpch','lineitem')}}
),

renamed as (
    select 
    L_orderkey as order_key,
    L_partkey as part_key,
    L_linenumber as line_number,
    L_quantity as quantity,
    L_extendedprice as extended_price ,
    L_discount as discount_pct,
    L_returnflag as returnflag,
    L_linestatus as line_status,
    L_shipdate as ship_date ,
    L_commitdate as commit_date,
    L_receiptdate as receipt_date,
    L_shipinstruct as ship_instructions,
    L_shipmode as ship_mode,
    round(L_extendedprice*(1-L_discount),2) as net_revenue,
    datediff('day',L_commitdate,L_receiptdate) as days_late,
    L_comment as customer_comment
from source
)

select * from renamed