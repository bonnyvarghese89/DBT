SELECT
    v.vendor_name,
    SUM(f.order_amount) AS total_spend
FROM {{ ref('fact_purchase_order') }} f
JOIN {{ ref('dim_vendor') }} v
    ON f.vendor_sk = v.vendor_sk
GROUP BY v.vendor_name
ORDER BY total_spend DESC