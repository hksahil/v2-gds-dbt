-- models/staging/stg_suppliers.sql
with source as (
    select * from {{ source('tpch', 'SUPPLIER') }}
),
renamed as (
    select
        S_SUPPKEY       as supplier_key,
        S_NAME          as supplier_name,
        S_ADDRESS       as supplier_address,
        S_NATIONKEY     as nation_key,
        S_PHONE         as phone_number,
        S_ACCTBAL       as account_balance,
        S_COMMENT       as supplier_comment
    from source
)
select * from renamed
