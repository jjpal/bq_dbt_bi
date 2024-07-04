{{
    config(
        materialized='table'
    )
}}

{%- set event_types = dbt_utils.get_column_values(
    table=ref('stg_events'),
    column='event_type'
) -%}

with events_aggregate_as_session_grain as (
    select
        session_guid
        , user_guid
        , count(event_guid) as events_count
        ,{%- for event_type in event_types %}
        sum(case when event_type='{{event_type}}' then 1
        else 0 end) as {{event_type}}
        {%- if not loop.last %},{% endif -%}
        {% endfor %}
        , count(distinct product_guid) as products_viewed_count    
        , count(distinct order_guid) as session_orders_count
        , current_timestamp() as insertion_timestamp_cfe
    from {{ ref('stg_events')}}
    group by 1, 2
)

select * from events_aggregate_as_session_grain