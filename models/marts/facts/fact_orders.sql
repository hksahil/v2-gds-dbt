-- models/marts/facts/fact_orders.sql
{{
    config(
        materialized  = 'incremental',
        unique_key    = ['order_key', 'line_number'],
        incremental_strategy = 'merge',
        on_schema_change = 'sync_all_columns',
        cluster_by    = ['order_date', 'order_year'],
        tags          = ['fact', 'incremental', 'orders']
    )
}}

with order_items as (
    select * from {{ ref('int_order_items') }}
    {% if is_incremental() %}
        -- Only load records newer than the last loaded ship_date
        where ship_date > (select max(ship_date) from {{ this }})
    {% endif %}
),
customers as (
    select customer_key, market_segment, nation_name, region_name, customer_tier
    from {{ ref('dim_customer') }}
),
parts as (
    select part_key, brand, part_type, part_category
    from {{ ref('dim_part') }}
),
final as (
    select
        -- keys
        oi.order_key,
        oi.line_number,
        oi.customer_key,
        oi.part_key,
        -- dates
        oi.order_date,
        oi.order_year,
        oi.order_month,
        oi.ship_date,
        -- order attrs
        oi.order_status,
        oi.order_priority,
        oi.ship_mode,
        oi.return_flag,
        -- customer attrs
        c.market_segment,
        c.nation_name        as customer_nation,
        c.region_name        as customer_region,
        c.customer_tier,
        -- part attrs
        p.brand              as part_brand,
        p.part_category,
        -- measures
        oi.quantity,
        oi.extended_price,
        oi.discount_pct,
        oi.net_revenue,
        oi.days_late,
        -- audit
        current_timestamp()  as dbt_loaded_at
    from order_items oi
    left join customers c on oi.customer_key = c.customer_key
    left join parts     p on oi.part_key     = p.part_key
)
select * from final
