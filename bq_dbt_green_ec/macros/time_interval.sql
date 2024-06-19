{% macro time_interval(timestamp_col1, timestamp_col2) %}
    {{ timestamp_col1 }} - {{ timestamp_col2 }}
{% endmacro %}