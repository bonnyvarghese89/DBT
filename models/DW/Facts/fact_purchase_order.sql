{{ config(
    materialized='incremental',
    schema='DW',
    unique_key='po_id'
) }}

WITH po AS (

    SELECT *
    FROM {{ ref('stg_purchase_order') }}

)
SELECT
    po.po_id, 
    po.vendor_id, 
    po.item_id, 
    po.unit_id, 
    po.order_date, 
    po.quantity, 
    po.order_amount,
    CURRENT_TIMESTAMP AS dw_created_at

FROM po


{% if is_incremental() %}

    {% set load_date = var("load_date", none) %}

    {% if load_date is not none %}

        WHERE po.order_date > '{{ load_date }}'

    {% else %}

        WHERE po.order_date >
            COALESCE(
                (SELECT MAX(order_date) FROM {{ this }}),
                '1900-01-01'
            )

    {% endif %}

{% endif %}