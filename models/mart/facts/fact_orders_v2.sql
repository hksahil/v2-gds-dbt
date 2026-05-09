{{
config(
    materialized='incremental',
    unique_key='order_key',
    incremental_strategy='merge'
)

}}

select * from {{ref('int_order_items')}}
{% if is_incremental() %}
where ship_date > (select max(ship_date) from {{this}})
{% endif %}
