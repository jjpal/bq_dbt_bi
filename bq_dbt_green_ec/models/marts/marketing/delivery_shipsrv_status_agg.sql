{{
    config(
        materialized='table'
    )
}}

{%- set delivery_statuses = dbt_utils.get_column_values(
    table=ref('fact_orders'),
    column='delivery_status',
    where='delivery_status is not null'
) -%}

with delivery_status_agg as (

    select 
        shipping_service
        ,{%- for status in delivery_statuses %}
        sum(case when delivery_status='{{status}}' then 1
            else 0 end) as num_delivery_{{status}}
        {%- if not loop.last %},{% endif -%}
        {% endfor %}
        , current_timestamp() as insertion_timestamp_mdssa
    from {{ ref('fact_orders')}}
    where shipping_service is not null
    group by 1
)

select * from delivery_status_agg