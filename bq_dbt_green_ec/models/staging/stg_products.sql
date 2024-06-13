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
        , lower(trim(name)) as product_name
        , price as product_price
        , inventory as product_inventory_amount
        , current_timestamp() as insertion_timestamp_sp
    from src_products
)

select * from renamed