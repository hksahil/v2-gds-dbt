-- models/staging/stg_regions.sql
with source as (select * from {{ source('tpch', 'REGION') }})
select
    R_REGIONKEY as region_key,
    R_NAME      as region_name,
    R_COMMENT   as region_comment
from source