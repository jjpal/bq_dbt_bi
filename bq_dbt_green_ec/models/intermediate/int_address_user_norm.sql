{{
    config(
        materialized='table'
    )
}}

select
    address_guid
    , lower(trim(address)) as user_address
    , zipcode as user_zipcode
    , lower(trim(state)) as user_state
    , lower(trim(country)) as user_country
    , current_timestamp() as insertion_timestamp_ia
from {{ ref('stg_addresses') }}
group by 1, 2, 3, 4, 5
order by state_count desc