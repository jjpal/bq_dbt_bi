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
    , count(state) as state_count
    , current_timestamp() as insertion_timestamp_ia
from {{ ref('stg_addresses') }}
group by state
order by state_count desc