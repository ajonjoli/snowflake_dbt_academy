with source_data as (
    select *
    from {{ source('raw_data', 'payments') }}
), cleaned_data as (
    SELECT
        p.payment_id::integer as payment_id,
        p.order_id::integer as order_id,
        COALESCE(p.amount, 0)::decimal(10, 2) AS payment_amount,
        CASE
            WHEN p.payment_method IN ('credit_card', 'cc', 'visa', 'mastercard', 'amex') THEN 'credit_card'
            WHEN p.payment_method IN ('bank_transfer', 'wire', 'ach') THEN 'bank_transfer'
            WHEN p.payment_method IN ('paypal', 'venmo') THEN 'digital_wallet'
            WHEN p.payment_method = 'gift_card' THEN 'gift_card'
            ELSE 'other'
        END AS payment_method,
        p.status AS payment_status
    FROM source_data p
)
select *
from cleaned_data
