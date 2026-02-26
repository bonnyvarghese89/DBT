{{ config(
    materialized='table',
    schema='DW'
) }}

SELECT
    {{ dbt_utils.generate_surrogate_key(['calendar_date']) }} AS date_sk,
    calendar_date,
    "year",
    "month",
    month_name,
    "quarter",
    CURRENT_TIMESTAMP AS dw_created_at
FROM {{ ref('stg_calendar') }}
