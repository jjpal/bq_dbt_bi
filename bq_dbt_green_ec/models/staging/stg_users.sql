{{
    config(
        materialized='table'
    )
}}

with src_users as (
  select * from {{ source('src_greenery','users') }}
)
, renamed as (
    select
        user_id as user_guid
        , first_name
        , last_name
        , email
        , phone_number
        , created_at as user_created_at_utc
        , updated_at as updated_at_utc
        , address_id as address_guid 
    from src_users
)

select * from renamed