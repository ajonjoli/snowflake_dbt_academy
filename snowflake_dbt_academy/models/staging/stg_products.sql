with source_data as (
    select *
    from {{ source('raw_data', 'products') }}
), category_department_map as (
    select *
    from {{ ref('category_to_department') }}
), cleaned_data as (
    select
        p.product_id,
        p.product_name,
        p.category as product_category,
        p.subcategory as product_subcategory,
        coalesce(cd.department, 'Other') as product_department
    from source_data p
    left join category_department_map cd
        on p.category = cd.category
)
select *
from cleaned_data
