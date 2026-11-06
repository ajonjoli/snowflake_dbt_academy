with source_data as (
    select *
    from {{ source('raw_data', 'line_items') }}
), cleaned_data as (
    select
        li.order_id,
        li.product_id,
        li.quantity,
        li.unit_price,
        coalesce(li.discount_pct, 0) as discount_pct,
        li.quantity * li.unit_price as line_total,
        li.quantity * li.unit_price * (1 - coalesce(discount_pct, 0) / 100) as line_total_after_discount
    from source_data li
)
select *
from cleaned_data
