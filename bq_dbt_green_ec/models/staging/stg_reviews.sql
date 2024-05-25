{{
    config(
        materialized='table'
    )
}}

with src_reviews as (
  select * from {{ source('src_greenery','reviews') }}
)
, renamed as (
    select
        review_id as review_guid
        , avg_rating
        , review
        , review_date
    from src_reviews
)

select * from renamed