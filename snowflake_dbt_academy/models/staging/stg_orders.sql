with source_data as (
    select *
    from {{ source('raw_data', 'orders') }}
), cleaned_data as (
    SELECT
        o.order_id::integer as order_id,
        o.customer_id::integer as customer_id,
        o.order_date::date as order_date,
        o.shipping_method,
        CASE
            WHEN o.status = 'completed' THEN 'completed'
            WHEN o.status = 'shipped' THEN 'in_transit'
            WHEN o.status IN ('pending', 'processing') THEN 'open'
            WHEN o.status IN ('cancelled', 'canceled', 'refunded') THEN 'cancelled'
            ELSE 'other'
        END AS order_status,
    FROM source_data o
)
select *
from cleaned_data
