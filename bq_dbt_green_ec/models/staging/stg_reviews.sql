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
        review_id as survey_review_guid
        , user_id  as user_guid
        , avg_rating as survey_rating
        , review as survey_review
        , review_date as survey_review_date
    from src_reviews
)

select * from renamed