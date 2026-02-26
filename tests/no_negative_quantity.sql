SELECT *
FROM {{ ref('fact_goods_received') }}
WHERE received_quantity < 0