{{
    config(
        materialized='table'
    )
}}

with src_products as (
  select * from {{ source('src_greenery','products') }}
)
, renamed as (
    select
        product_id as product_guid
        , name as product_name
        , price as product_price
        , inventory as product_inventory
    from src_greenery_products
)

select * from renamed