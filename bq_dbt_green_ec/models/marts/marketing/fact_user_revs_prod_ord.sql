{{
    config(
        materialized='table'
    )
}}

select 
    fo.user_guid
    , du.user_full_name
    , du.user_email
    , du.user_phone_number
    , du.last_update_activity as user_last_update_activity
    , du.user_account_age_day
    , dr.product_name 
    , dr.product_price
    , dr.rating_review
    , dr.survey_review
    , dr.review_date
    , fo.discount
    , fo.promo_status
    , fo.items_ordered
    , fo.orders_created_at_utc   
    , fo.product_inventory_amount
    , current_timestamp() as insertion_timestamp_mfurpo
from {{ ref('fact_orders')}} as fo
left join {{ ref('dim_users')}} as du
    on fo.user_guid = du.user_guid
left join {{ ref('dim_reviews')}} as dr
    on du.user_guid = dr.user_guid
group by 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16        

