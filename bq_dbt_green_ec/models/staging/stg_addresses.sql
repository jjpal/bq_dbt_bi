{{
    config(
        materialized='table'
    )
}}

with src_address as (
    select * from {{ source('src_greenery','addresses')}}
)
,
renamed as (
    select
        address_id as address_guid 
        , address
        , zipcode
        , state
        , country    
    from src_greenery_addresses
)

select * from renamed