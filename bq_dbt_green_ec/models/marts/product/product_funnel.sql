{{
    config(
        materialized='table'
    )
}}

with event_session_counts as(
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
    , round((page_views::numeric / page_views:: numeric),2) || '%' as page_view_flow
    , round((add_to_carts::numeric / page_views:: numeric),2) || '%' as view_cart_flow  
    , round((checkouts::numeric / add_to_carts:: numeric),2) || '%' as  cart_checkout_flow 
    , round((checkouts::numeric / page_views:: numeric),2) || '%' as page_view_checkout_flow
from event_session_counts