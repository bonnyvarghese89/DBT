{% macro select_trimmed_varchar(relation) %}

    {% set columns = adapter.get_columns_in_relation(relation) %}

    {% for col in columns %}
        {% if col.data_type | upper in ['VARCHAR', 'TEXT', 'STRING'] %}

            TRIM({{ col.name }}) AS {{ col.name }}
            {% if not loop.last %},{% endif %}

        {% endif %}
    {% endfor %}

{% endmacro %}