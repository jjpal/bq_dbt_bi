{{
    config(
        materialized='table'
    )
}}

select
    int_ordcstd.user_guid
    , int_ordcstd.order_count
    , int_ordcstd.time_delivery
    , fo.order_total
    , fo.tracking_guid
    , fo.shipping_service
    , int_uaa.user_created_at_utc
    , int_uaa.user_full_name
    , int_uaa.user_account_age_day
    , du.user_email
    , du.user_phone_number
    , du.user_state
    , current_timestamp() as insertion_timestamp_mfctuo  
from {{ ref('int_orders_cnt_status_time_del') }} as int_ordcstd 
join {{ ref('fact_orders') }} as fo
    on int_ordcstd.user_guid = fo.user_guid
join {{ ref('int_users_acct_age') }} as int_uaa
    on fo.user_guid = int_ordcstd.user_guid
join {{ ref('dim_users') }} as du
    on fo.user_guid = du.user_guid