{{
    config(
        materialized='table'
    )
}}

select
    o_items.order_guid
    , o_items.product_guid
    , o_items.quantity as items_ordered
    , prods.product_name    
    , prods.product_price
    , prods.product_inventory_amount
    , current_timestamp() as insertion_timestamp_ioi 
from {{ ref('stg_order_items') }} as o_items
inner join {{ ref('stg_products') }} as prods
on o_items.product_guid = prods.product_guid
group by 1, 2, 4, 5, 6
order by product_ordered desc  

