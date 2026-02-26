{{ config(
    materialized='ephemeral'
) }}

SELECT
    vendor_id,
    UPPER(vendor_name)      AS vendor_name,
    UPPER(vendor_country)          AS country,
    CURRENT_TIMESTAMP       AS processed_at
FROM {{ ref('stg_vendor') }}
