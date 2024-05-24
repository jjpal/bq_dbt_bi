{{
  config(
    materialized='table'
  )
}}

with src_orders as (
  select * from {{ source('src_greenery','orders') }}
)
, renamed as (
    select
        order_id as order_guid
        , promo_id as promo_guid
        , user_id as user_guid    
        , address_id as address_guid
        , created_at as orders_created_at_utc
        , order_cost
        , shipping_cost
        , order_total
        , tracking_id as tracking_guid
        , shipping_service
        , estimated_delivery_at as estimated_delivery_at_utc
        , delivered_at as delivered_at_utc
        , status as order_status
    from src_orders
)

select * from renamed