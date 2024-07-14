{{
    config(
        materialized='table'
    )
}}

with orders_products as (
    select
        fo.order_guid
        , dusers.user_guid
        , dusers.user_state
        , dprods.product_guid
        , dprods.product_name
        , dprods.product_price
        , dprods.product_inventory_amount
        , ioi.items_ordered
        , fo.created_at_utc
        , current_timestamp() as insertion_timestamp_fpo
    from {{ ref('fact_orders')}} as fo
    left join {{ ref('int_order_items_prod_ord_agg')}} as ioi      
        on ioi.order_guid = fo.order_guid
    left join {{ ref('dim_products')}} as dprods                   
        on ioi.product_guid = dprods.product_guid
    left join {{ ref('dim_users')}} as dusers                       
        on fo.user_guid = dusers.user_guid
    group by 1,2,3,4,5,6,7,8
    order by 1
)
,
agg_pivot_product as (
    select 
        op.product_guid
        , op.product_name
        , sum(op.items_ordered) as units_sold
        , round(sum(op.product_price * op.items_ordered)) as expected_rev_no_disc_tax
        , round(sum((op.product_price * op.items_ordered * (1 - op.discount)) * (1 + , str.combined_rate)), 2) as rev_with_tax_and_discount
        , op.product_inventory_amount - coalesce(sum(op.items_ordered), 0) as current_inventory
        , count(distinct op.order_guid) as times_ordered
        , count(distinct op.user_guid) as num_users_ordered
        , max(op.created_at_utc) as last_ordered  
    from orders_products as op  
    left join {{ ref('sales_tax_rates_us_st_local') }} as str 
	    on op.state = str.state  
    group by 1,2  
    order by 2 
)

select * from aggregated_and_pivoted_to_product