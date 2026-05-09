-- models/staging/stg_lineitems.sql
with source as (
    select * from {{ source('tpch', 'LINEITEM') }}
),
renamed as (
    select
        L_ORDERKEY                                              as order_key,
        L_PARTKEY                                               as part_key,
        L_LINENUMBER                                            as line_number,
        L_QUANTITY                                              as quantity,
        L_EXTENDEDPRICE                                         as extended_price,
        L_DISCOUNT                                              as discount_pct,
        L_RETURNFLAG                                            as return_flag,
        L_LINESTATUS                                            as line_status,
        L_SHIPDATE                                              as ship_date,
        L_COMMITDATE                                            as commit_date,
        L_RECEIPTDATE                                           as receipt_date,
        L_SHIPINSTRUCT                                          as ship_instructions,
        L_SHIPMODE                                              as ship_mode,
        -- derived metrics
        round(L_EXTENDEDPRICE * (1 - L_DISCOUNT), 2)           as net_revenue,
        datediff('day', L_COMMITDATE, L_RECEIPTDATE)            as days_late
    from source
)
select * from renamed