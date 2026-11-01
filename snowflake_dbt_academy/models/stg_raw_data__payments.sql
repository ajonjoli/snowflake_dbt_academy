
with source as (

    select * from {{ source('raw_data', 'payments') }}

),

renamed as (

    select
        payment_id,
        order_id,
        payment_method,
        amount,
        status

    from source

)

select * from renamed

