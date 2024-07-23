{{
    config(
        materialized='table'
    )
}}

select 
    ievent_s.product_guid
    , iordi_pdo.product_name
    , sum(ievent_s.add_to_carts) / count(distinct ievent_s.session_guid) as conver_rate_by_prod
    , current_timestamp() as insertion_timestamp_fct_usp
from {{ ref('int_events_sessions_agg') }} as ievent_s
left join {{ ref('int_order_items_prod') }} as iordi_pdo
on ievent_s.product_guid =  iordi_pdo.product_guid
group by 1, 2
order by conver_rate_by_prod desc 
