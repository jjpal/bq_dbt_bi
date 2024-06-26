{{
    config(
        materialized='table'
    )
}}

select 
    user_guid
    , coalesce(first_name, '') ||' '|| coalesce(last_name, '') as user_full_name 
    , email as user_email
    , phone_number as user_phone_number
    , address_guid as user_address_guid       
    , user_created_at_utc
    , updated_at_utc
    , timestamp_diff(current_timestamp(), user_created_at_utc, second) as user_account_age_sec
    , timestamp_diff(current_timestamp(), user_created_at_utc, minute) as user_account_age_min
    , timestamp_diff(current_timestamp(), user_created_at_utc, hour) as user_account_age_hr
    , timestamp_diff(current_timestamp(), user_created_at_utc, day) as user_account_age_day
    , current_timestamp() as insertion_timestamp_iu  
from {{ ref('stg_users') }}
order by user_account_age_day desc    