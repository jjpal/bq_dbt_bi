{{
    config(
        materialized='table'
    )
}}

with event_session_counts as (
    select
        count(distinct (session_guid)) as total_sessions 
        , count(distinct ( case when page_view > 0 then session_guid end )) as page_views 
        , count(distinct ( case when add_to_cart > 0 then session_guid end )) as add_to_carts
        , count(distinct ( case when checkout > 0 then session_guid end )) as checkouts
        , current_timestamp() as insertion_timestamp_ppf
    from {{ ref('fact_events') }}
)

select
    total_sessions 
    , concat(cast(round(page_views / page_views,2) as string), '%') as page_view_flow
    , concat(cast(round(add_to_carts / page_views,2) as string), '%') as view_cart_flow  
    , concat(cast(round(checkouts / add_to_carts,2) as string), '%') as cart_checkout_flow 
    , concat(cast(round(checkouts / page_views,2) as string), '%') as page_view_checkout_flow
from event_session_counts

