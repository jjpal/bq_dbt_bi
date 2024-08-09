{{
    config(
        materialized='table'
    )
}}

select
    du.user_guid
    , du.user_created_at_utc
    , int_uaa.user_account_age_day   
    , du.user_email
    , du.user_phone_number
    , du.user_address_guid
    , du.user_state
    , int_ordcstd.order_count
    , fo.order_total
    , fo.tracking_guid
    , fo.shipping_service
    , int_ordcstd.time_delivery
    , current_timestamp() as insertion_timestamp_mfctuo  
from {{ ref('int_orders_cnt_status_time_del') }} as int_ordcstd 
inner join {{ ref('fact_orders') }} as fo
    on int_ordcstd.order_guid = fo.order_guid
inner join {{ ref('int_users_acct_age') }} as int_uaa
    on fo.user_guid = int_ordcstd.user_guid
inner join {{ ref('dim_users') }} as du
    on int_uaa.user_address_guid = du.user_address_guid
group by 1,2,3,4,5,6,7,8,9,10,11,12,13    