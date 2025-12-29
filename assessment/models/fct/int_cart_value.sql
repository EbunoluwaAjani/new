select
    e.customer_id,
    e.session_id,
    sum(p.price) as cart_value
from {{ref('int_session')}} e
join {{ref('dim_product')}} p
    on p.product_id = e.product
where e.event_type = 'ADD_PRODUCT_TO_CART'
group by 1,2