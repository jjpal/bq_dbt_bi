{{
    config(
        materialized='table'
    )
}}

select
    intp.product_guid
    , iprod.product_name
    , iprod.product_price
    , iprod.product_inventory
    , iprod.product_ordered
    , events.session_guid as session_guid
    , events.page_url as product_url
    , current_timestamp() as insertion_timestamp_cdp
from {{ ref('int_order_items_product_agg') }} iprod
left join {{ ref('stg_greenery__events') }} events
    on intp.product_guid = e.product_guid