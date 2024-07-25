{{
    config(
        materialized='table'
    )
}}

select 
    du.user_guid
    , sum(fo.order_total) as lifetime_value
    , case when sum(fo.order_total) > 1000 then 'high value' 
            when sum(fo.order_total) between 500 and 1000 then 'medium value' 
            else 'low value' end as customer_segment
    , current_timestamp() as insertion_timestamp_mcsc       
from {{ ref('fact_orders') }} as fo
join {{ ref('dim_users') }} as du
    on fo.user_guid = du.user_guid
group by du.user_guid
