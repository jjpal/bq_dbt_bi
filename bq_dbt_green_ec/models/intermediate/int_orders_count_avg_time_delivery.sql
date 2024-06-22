{{
   config(
      materialized='table'
   )
}}

select
   user_guid
   , count(order_guid) as number_of_orders 
   , avg(delivered_at_utc - orders_created_at_utc) as avg_delivery_time 
   , {{ time_interval('delivered_at_utc', 'orders_created_at_utc')}} as time_delivery
   , current_timestamp() as insertion_timestamp_io
from {{ ref('stg_orders') }} as ords
group by 1, 3
order by time_delivery desc





