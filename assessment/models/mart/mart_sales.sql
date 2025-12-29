SELECT
    DATE_TRUNC('week', oi.created_at) AS week_start,
    SUM(oi.quantity * (p.price * p.discount_percent)) AS total_discount
FROM {{ ref('fct_orderitem') }} oi
JOIN {{ ref('dim_product') }} p
    ON oi.product_id = p.product_id
GROUP BY 1
