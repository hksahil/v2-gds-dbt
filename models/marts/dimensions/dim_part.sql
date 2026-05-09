-- models/marts/dimensions/dim_part.sql
select
    part_key,
    part_name,
    manufacturer,
    brand,
    part_type,
    part_size,
    container_type,
    retail_price,
    split_part(part_type, ' ', -1) as part_category  -- e.g. BRASS, COPPER
from {{ ref('stg_parts') }}
