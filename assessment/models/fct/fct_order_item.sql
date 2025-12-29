select
    order_item_id,
    oi.order_id,
    oi.product_id,
    oi.quantity,
    oi.price as selling_price,
    p.price as list_price,
    (p.price - oi.price) * oi.quantity as discount_amount,
    o.created_at::date as order_date
from {{ ref('fct_orderitem') }} oi
join {{ ref('fct_orders') }} o
  on oi.order_id = o.order_id
join {{ ref('dim_product') }} p
  on oi.product_id = p.product_id
