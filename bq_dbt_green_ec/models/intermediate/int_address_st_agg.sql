{{
    config(
        materialized='table'
    )
}}

select
    address_guid as address_guid
    , lower(trim(address)) as address
    , zipcode as zipcode
    , lower(trim(state)) as state
    , lower(trim(country)) as country
    , count(state) as state_count
from {{ ref('stg_addresses') }}
group by state
order by state_count desc
