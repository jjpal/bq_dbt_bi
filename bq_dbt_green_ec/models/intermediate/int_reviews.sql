{{
    config(
        materialized='table'
    )
}}

select 
    review_guid
    , user_guid  
    , product_guid        
    , rating_review
    , survey_review
    , review_date
    , current_timestamp() as insertion_timestamp_ir
from {{ ref('stg_reviews') }}
