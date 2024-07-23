{{
   config(
      materialized='table'
   )
}}

{%
   set order_statuses = dbt_utils.get_query_results_as_dict(
   "select 
      distinct cast(order_status as string) as order_status,
      order_status as column_name 
   from " ~ ref('stg_orders')
   )
%}

select
   order_guid
   , user_guid
   , address_guid
   , count(order_guid) as order_count
   , orders_created_at_utc
   {%- for order_status in order_statuses['order_status'] %}
   , sum(case when order_status = {{ quote_literal(order_status) }} then 1 else 0 end) as {{ order_statuses['column_name'][loop.index0] }} 
   {%- endfor %} 
   , avg(delivered_at_utc - orders_created_at_utc) as avg_delivery_time 
   , {{ time_interval('delivered_at_utc', 'orders_created_at_utc') }} as time_delivery
   , current_timestamp() as insertion_timestamp_ioa
from {{ ref('stg_orders') }} as ords
group by 
   order_guid
   , user_guid
   , address_guid
   , orders_created_at_utc
   , delivered_at_utc
order by time_delivery desc