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
        , address
        , zipcode
        , state
        , country
        , current_timestamp() as insertion_timestamp_sa
    from src_addresses
)

select * from renamed