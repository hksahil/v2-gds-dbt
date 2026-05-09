{{ config(
  materialized='table',
  alias='orders_v33',
  tags=['orders', 'daily'],
  meta={'owner': 'data-team'},
  persist_docs={'relation': true},
  unique_key='order_id',
  incremental_strategy='merge',
  on_schema_change='sync_all_columns',
  cluster_by=['order_date', 'region'],
  automatic_clustering =true,
  snowflake_warehouse='COMPUTE_WH',
  transient=false,
  copy_grants=true,
  query_tag='orders_pipeline',
  pre_hook="ALTER SESSION SET TIMEZONE = 'UTC'",
  post_hook="GRANT SELECT ON {{ this }} TO ROLE reporter",
  grants={'select': ['reporter']},
  enabled=true,
  full_refresh=false
) }}

SELECT * FROM prod.prod.orders_v3