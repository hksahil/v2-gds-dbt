-- snapshots/scd2_supplier.sql
{% snapshot scd2_supplier %}

{{
    config(
        target_schema = 'snapshots',
        unique_key    = 'supplier_key',
        strategy      = 'check',
        check_cols    = ['supplier_name', 'supplier_address',
                         'phone_number', 'account_balance',
                         'nation_key'],
        invalidate_hard_deletes = true
    )
}}

select
    supplier_key,
    supplier_name,
    supplier_address,
    phone_number,
    account_balance,
    nation_key,
    supplier_comment
from {{ ref('stg_suppliers') }}

{% endsnapshot %}
