{{
    config(
        materialized='table'
    )
}}

select
    i_users.user_guid
    , i_users.user_full_name
    , i_users.user_email
    , i_users.user_phone_number
    , i_users.user_address_guid  
    , i_users.user_created_at_utc
    , i_users.updated_at_utc
    , {{ time_interval('updated_at_utc', 'user_created_at_utc')}} as last_update_activity
    , i_users.user_account_age_sec
    , i_users.user_account_age_min
    , i_users.user_account_age_hr
    , i_users.user_account_age_day
    , i_addr.user_address
    , i_addr.user_zipcode
    , i_addr.user_state
    , i_addr.user_country
    , current_timestamp() as insertion_timestamp_cdu
from {{ ref('int_users_acct_age') }} as i_users
left join {{ ref('int_address_user_norm') }} as i_addr
on i_users.user_address_guid = i_addr.address_guid