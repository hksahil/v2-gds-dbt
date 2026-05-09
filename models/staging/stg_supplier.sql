with source as (
select * from {{source('tpch','supplier')}}
),

renamed as (
    select 
    s_name as supplier_name,
    s_acctbal as account_balance,
    s_suppkey as supplier_key,
    S_NATIONKEY as nation_key
from source
)

select * from renamed