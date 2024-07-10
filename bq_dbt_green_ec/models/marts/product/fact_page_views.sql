{{
    config(
    materialized='table'
    )
}}

with event_views_per_session as (
    select 
        user_guid 
        , event_guid as page_view_guid
        , event_type
        , page_url
        , session_guid
        , events_created_at_utc as viewed_at_utc
        , current_timestamp() as insertion_timestamp_pfpv
    from {{ ref('stg_events') }}
)

select
        sum(case when event_type = 'page_view' then 1 else 0 end) as page_view
        , sum(case when event_type = 'add_to_cart' then 1 else 0 end) as add_to_cart
        , sum(case when event_type = 'checkout' then 1 else 0 end) as check_out
        , sum(case when event_type = 'package_shipped' then 1 else 0 end) as package_shipped
from event_views_per_session
where event_type = 'page_view'