with source_data as (
    select *
    from {{ source('raw_data', 'web_events') }}
), cleaned_data as (
    select
        we.event_id::integer as event_id,
        we.received_at::timestamp_ntz as received_at,
        we.payload:event_type::string as event_type,
        we.payload:user_id::integer as user_id,
        we.payload:page::string as page_url,
        we.payload:total::decimal(10, 2) as event_total,
        -- extracs nested json objects attributes
        we.payload:device.type::string as device_type,
        we.payload:device.browser::string as browser,
        we.payload:utm.source::string as utm_source,
        we.payload:utm.campaign::string as utm_campaign
    from source_data we
)
select *
from cleaned_data