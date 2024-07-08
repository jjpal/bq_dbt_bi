{{
    config(
        materialized='table'
    )
}}

select 
    revs.review_guid
    , revs.user_guid  
    , revs.product_guid        
    , revs.rating_review
    , revs.survey_review
    , revs.review_date
    , prods.product_name 
    , prods.product_price
    , current_timestamp() as insertion_timestamp_cdr
from {{ ref('stg_reviews') }} as revs
inner join {{ ref('stg_products') }} as prods
    on revs.product_guid = prods.product_guid
where revs.product_guid is not null
group by 1,2,3,4,5,6,7,8