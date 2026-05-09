-- models/marts/dimensions/dim_customer.sql
with customers as (
    select * from {{ ref('stg_customers') }}
),
nations as (
    select * from {{ ref('stg_nations') }}
),
regions as (
    select * from {{ ref('stg_regions') }}
),
final as (
    select
        c.customer_key,
        c.customer_name,
        c.customer_address,
        c.phone_number,
        c.account_balance,
        c.market_segment,
        n.nation_name,
        r.region_name,
        case
            when c.account_balance >= 5000 then 'High Value'
            when c.account_balance >= 1000 then 'Mid Value'
            else 'Low Value'
        end as customer_tier
    from customers c
    left join nations n on c.nation_key = n.nation_key
    left join regions r on n.region_key  = r.region_key
)
select * from final
