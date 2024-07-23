{{
    config(
        materialized='table'
    )
}}

select
    iprod.product_guid
    , iprod.product_name
    , iprod.product_price
    , iprod.product_inventory_amount
    , iprod.items_ordered
    , events.session_guid as session_guid
    , events.page_url as product_url
    , current_timestamp() as insertion_timestamp_cdp
from {{ ref('int_order_items_prod') }} iprod
left join {{ ref('stg_events') }} events
    on iprod.product_guid = events.product_guid