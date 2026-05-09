-- models/marts/dimensions/dim_date.sql
-- Requires: dbt_utils package
{{ config(materialized='table') }}

with dates as (
    {{ dbt_utils.date_spine(
        datepart='day',
        start_date="cast('1990-01-01' as date)",
        end_date="cast('2030-12-31' as date)"
    ) }}
),
final as (
    select
        cast(date_day as date)              as date_key,
        date_day                            as full_date,
        year(date_day)                      as year,
        quarter(date_day)                   as quarter,
        month(date_day)                     as month,
        day(date_day)                       as day_of_month,
        dayofweek(date_day)                 as day_of_week,
        dayname(date_day)                   as day_name,
        monthname(date_day)                 as month_name,
        case when dayofweek(date_day) in (1,7)
             then true else false end        as is_weekend
    from dates
)
select * from final
