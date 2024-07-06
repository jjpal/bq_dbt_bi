{{
    config(
        materialized='table'
    )
}}

select
    ord.order_guid
    , ord.promo_guid
    , ord.user_guid
    , ord.order_total
    , ord.orders_created_at_utc
    , ord.tracking_guid
    , ord.shipping_service
    , ord.delivered_at_utc
    , op.product_guid
    , op.items_ordered                                  
    , op.product_price
    , op.product_inventory
from {{ ref('stg_orders') }} as ord
left join {{ ref('int_order_items_prod_ord_agg') }} as op
    on oi.product_guid = op.product_guid