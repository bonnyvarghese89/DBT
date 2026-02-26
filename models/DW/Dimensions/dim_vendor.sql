{{ config(
    materialized='table',
    schema='DW',
     post_hook="
        INSERT INTO MANU_DW.audit_log
        SELECT
            '{{ this.name }}',
            'SUCCESS',
            COUNT(*),
            CURRENT_TIMESTAMP
        FROM {{ this }}
    "
) }}

{% set business_keys = ['vendor.vendor_id','vendor.country'] %}

WITH vendor AS (

    SELECT *
    FROM {{ ref('int_vendor_clean') }}

),

category AS (

    SELECT *
    FROM {{ ref('vendor_category') }}

)

SELECT
    {{ dbt_utils.generate_surrogate_key(business_keys) }} AS vendor_sk,
    vendor.vendor_id,
    vendor.vendor_name,
    category.vendor_category,
    CURRENT_TIMESTAMP AS dw_created_at

FROM vendor
LEFT JOIN category
    ON vendor.vendor_id = category.vendor_id
