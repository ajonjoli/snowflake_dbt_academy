with source_data as (
    select *
    from {{ source('raw_data', 'customers') }}
), country_map as (
    select *
    from {{ ref('country_mapping') }}
), cleaned_data as (
    SELECT
        c.customer_id::integer as customer_id,
        TRIM(UPPER(c.first_name)) AS first_name,
        TRIM(UPPER(c.last_name)) AS last_name,
        TRIM(LOWER(c.email)) AS email,
        COALESCE(TRIM(c.phone), 'N/A') AS phone,
        c.created_at::timestamp_ntz as created_at,
        coalesce(cm.country_code, trim(upper(c.country))) as country_standardized
    FROM source_data c
    LEFT JOIN country_map cm
        ON trim(upper(c.country)) = upper(cm.country_raw)
    WHERE c.created_at IS NOT NULL
    AND c.email IS NOT NULL
    AND c.email LIKE '%@%'
    QUALIFY ROW_NUMBER() OVER (PARTITION BY TRIM(LOWER(c.email)) ORDER BY c.created_at DESC) = 1
)
select *
from cleaned_data
