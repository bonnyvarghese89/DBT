{{ config(
    materialized='view',
    schema='DW'
) }}

SELECT
    {{ dbt_utils.star(from=ref('stg_calendar'), except=["calendar_date","month_name"]) }}
FROM {{ ref('stg_calendar') }}