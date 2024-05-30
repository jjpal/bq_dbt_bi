{{
    config(
        materialized='table'
    )
}}

with src_addresses as (
    select * from {{ source('src_greenery','addresses')}}
)
,
renamed as (
    select
        address_id as address_guid 
        , lower(trim(address))
        , zipcode
        , lower(trim(state))
        , country    
    from src_addresses
)

select * from renamed