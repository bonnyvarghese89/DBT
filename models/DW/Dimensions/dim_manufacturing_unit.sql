{{ config(
    materialized='table',
    schema='DW'
) }}

SELECT
    Upper({{ dbt_utils.generate_surrogate_key(['unit_id']) }}) AS unit_sk,
    unit_id,
    unit_name,
    location,
    CURRENT_TIMESTAMP AS dw_created_at
FROM {{ ref('stg_manufacturing_unit') }}
