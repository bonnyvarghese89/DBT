{% snapshot snap_vendor %}

{{
    config(
        target_schema='DW',
        unique_key='vendor_id',
        strategy='check',
        check_cols=['vendor_name']
    )
}}

SELECT
    vendor_id,
    vendor_name,
    CURRENT_TIMESTAMP AS updated_at
FROM {{ ref('stg_vendor') }}

{% endsnapshot %}