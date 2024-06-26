{{
    config(
        materialized='table'
    )
}}

with src_promos as (
  select * from {{ source('src_greenery','promos') }}
)
, renamed as (
    select
        promo_id as promo_guid
        , discount
        , status as promo_status
        , current_timestamp() as insertion_timestamp_spm
    from src_promos
)

select * from renamed