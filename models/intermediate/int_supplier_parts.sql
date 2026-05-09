-- models/intermediate/int_supplier_parts.sql
-- Enriches partsupp with supplier and nation details
with partsupps as (
    select * from {{ source('tpch', 'PARTSUPP') }}
),
suppliers as (
    select * from {{ ref('stg_suppliers') }}
),
nations as (
    select * from {{ ref('stg_nations') }}
),
regions as (
    select * from {{ ref('stg_regions') }}
),
enriched as (
    select
        ps.PS_PARTKEY    as part_key,
        ps.PS_SUPPKEY    as supplier_key,
        ps.PS_AVAILQTY   as available_qty,
        ps.PS_SUPPLYCOST as supply_cost,
        s.supplier_name,
        s.account_balance as supplier_balance,
        n.nation_name,
        r.region_name
    from partsupps ps
    left join suppliers s on ps.PS_SUPPKEY = s.supplier_key
    left join nations n   on s.nation_key  = n.nation_key
    left join regions r   on n.region_key  = r.region_key
)
select * from enriched
