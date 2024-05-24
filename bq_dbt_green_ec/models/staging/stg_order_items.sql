{{
    config(
        materialized='table'
    )
}}

with src_order_items as (
  select * from {{ source('src_greenery','order_items') }}
)
, renamed as (
    select
        order_id as order_guid
        , product_id as product_guid 
        , quantity 
    from src_order_items
)

select * from renamed