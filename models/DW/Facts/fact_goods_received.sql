{{ config(
    materialized='incremental',
    schema='DW',
    unique_key='grn_id'
) }}

WITH gr AS (
    SELECT *
    FROM {{ ref('stg_goods_received') }}
),

vendor AS (
    SELECT vendor_sk, vendor_id
    FROM {{ ref('dim_vendor') }}
),

item AS (
    SELECT item_sk, item_id
    FROM {{ ref('dim_item') }}
),

calendar AS (
    SELECT date_sk, calendar_date
    FROM {{ ref('dim_calendar') }}
),

 max_loaded AS (
    SELECT COALESCE(MAX(grn_id),'0') AS max_po_id
    FROM {{ this }}
 )


SELECT
    gr.grn_id,
    gr.po_id,
    item.item_sk,
    calendar.date_sk,

    gr.received_quantity,

    CURRENT_TIMESTAMP AS dw_created_at

FROM gr

LEFT JOIN item
    ON gr.po_id = item.item_id

LEFT JOIN calendar
    ON gr.received_date = calendar.calendar_date

{% if is_incremental() %}
WHERE grn_id > (SELECT max_po_id FROM max_loaded)
{% endif %}