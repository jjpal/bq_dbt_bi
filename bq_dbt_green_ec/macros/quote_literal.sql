{% macro quote_literal(value) %}
    {% set escaped_value = value | replace("'", "''") %}
    {% set quoted_value = "'" ~ escaped_value ~ "'" %}
    {{ return(quoted_value) }}
{% endmacro %}