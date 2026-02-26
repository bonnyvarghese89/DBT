{{ config(
    materialized='table',
    schema='DW'
) }}

SELECT
    Upper({{ dbt_utils.generate_surrogate_key(['item_id']) }}) as item_sk,
    {{ select_trimmed_varchar(ref('stg_item')) }},
    CURRENT_TIMESTAMP AS dw_created_at
FROM {{ ref('stg_item') }}
