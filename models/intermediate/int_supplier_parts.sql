with 
partssupps as (
    select * from {{source('tpch','partsupp')}}
),
suppliers as (
    select * from {{ref('stg_supplier')}}
),
nations as (
    select * from {{ref('stg_nation')}}
),
regions as (
    select * from {{ref('stg_regions')}}
),
enriched as (
select 
ps.ps_partkey as part_key,
ps.ps_suppkey as supplier_key,
ps.ps_availqty as available_qty,
ps.ps_supplycost as supply_cost,
s.supplier_name as supplier_name,
s.account_balance as supplier_balance,
n.nation_name,
r.region_name,
from partssupps ps 
left join suppliers s on ps.ps_suppkey=s.supplier_key
left join nations n on s.nation_key=n.nation_key
left join regions r on r.region_key=n.region_key
)
select * from enriched