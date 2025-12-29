{{ config(
    materialized = 'incremental',
    unique_key   = 'customer_id',
    on_schema_change = 'fail'
) }}

with src_customer as (
    select
        customer_id,
        customer_name,
        email,
        phone_number,
        created_at,
        modified_at
    from {{ ref('src_customer') }}
)

select
    customer_id,
    customer_name,
    email,
    phone_number,
    created_at,
    modified_at
from src_customer

{% if is_incremental() %}
where modified_at > (
    select max(modified_at)
    from {{ this }}
)
{% endif %}
