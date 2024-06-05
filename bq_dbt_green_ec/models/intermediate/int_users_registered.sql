{{
    config(
        materialized='table'
    )
}}

select 
    user_guid
    , users_created_at_utc as user_registered_on
    , coalesce(first_name, '') || ' '|| coalesce(last_name, '') as user_full_name        
    , timestamp_diff(current_timestamp(), user_registered_on, second) as user_account_age_sec
    , timestamp_diff(current_timestamp(), user_registered_on, minute) as user_account_age_min
    , timestamp_diff(current_timestamp(), user_registered_on, hour) as user_account_age_hr
    , timestamp_diff(current_timestamp(), user_registered_on, day) as user_account_age_day
    , timestamp_diff(current_timestamp(), user_registered_on, month) as user_account_age_month
    , timestamp_diff(current_timestamp(), user_registered_on, year) as user_account_age_yr  
from {{ ref('stg_users') }}
order by user_account_age desc    