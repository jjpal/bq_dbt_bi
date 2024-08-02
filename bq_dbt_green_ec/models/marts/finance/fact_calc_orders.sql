{{
    config(
        materialized='table'
    )
}}

with calc_revenue as (
    select 
        fo.user_guid
        , du.user_full_name
        round(sum(fo.order_total*(1-(coalesce(fo.discount, 0)/100)) * (1+coalesce(str.combined_rate, 0))), 2) as total_revenue
    from {{ ref('fact_orders') }} as fo
    left join {{ ref('dim_users') }} as du
        on fo.user_guid = du.user_guid
    left join {{ ref('sales_tax_rates_us_st_local') }} as str 
        on du.user_state = str.state
    --where fo.promo_status = 'active'
    group by fo.user_guid, du.user_full_name
)
select
    fo.user_guid
    , cr.user_name
    , count(distinct fo.order_guid) as order_count
    , sum(fo.order_cost) as customer_cost_agg
    , sum(fo.shipping_cost) as shipping_cost_agg
    , sum(fo.order_total) as order_total_agg
    , cr.total_revenue
    , sum(fo.order_cost) / count(fo.order_guid) as average_order_value
    , sum(fo.order_cost) / count(distinct fo.orders_created_at_utc) as revenue_per_day
from {{ ref('fact_orders') }} as fo
left join calc_revenue as cr 
    on fo.user_guid = cr.user_guid
group by fo.user_guid, cr.user_full_name, cr.total_revenue;