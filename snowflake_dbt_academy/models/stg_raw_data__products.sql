
with source as (

    select * from {{ source('raw_data', 'products') }}

),

renamed as (

    select
        product_id,
        product_name,
        category,
        subcategory

    from source

)

select * from renamed

