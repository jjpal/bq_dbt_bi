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
        , user_id  as user_guid  
        , product_id as product_guid         --
        , rating as rating_review
        , review as survey_review
        , review_date as review_date
        , current_timestamp() as insertion_timestamp_sr
    from src_reviews
)

select * from renamed