with customer as (
    select * from {{ref('stg_customers')}},
),
nations as (
    select * from {{ref('stg_nation')}}
),
region as (
    select * from {{ref('stg_regions')}}
),

final as (
    select
    c.customer_key,
    c.customer_name,
    c.customer_adress,
    c.phone_number,
    c.market_segment,
    c.account_balance,
    n.nation_name,
    r.region_name,
    case 
    when c.account_balance >=5000 then 'high value'
    when c.account_balance >=1000 then 'mid value'
    else 'low value' end as customer_tier
    from customer c
    join nations n on n.nation_key=c.nation_key
    join region r on r.region_key=n.region_key
)
select * from final