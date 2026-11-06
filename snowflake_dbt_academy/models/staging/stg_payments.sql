with source_data as (
    select *
    from {{ source('raw_data', 'payments') }}
), payment_method_seed as (
    select *
    from {{ ref('payment_method_mapping') }}
), cleaned_data as (
    SELECT
        p.payment_id::integer as payment_id,
        p.order_id::integer as order_id,
        COALESCE(p.amount, 0)::decimal(10, 2) AS payment_amount,
        coalesce(pm.payment_method_clean, 'other') as payment_method,
        p.status AS payment_status
    FROM source_data p
    LEFT JOIN payment_method_seed pm
        ON lower(trim(p.payment_method)) = lower(pm.payment_method_raw)
)
select *
from cleaned_data
