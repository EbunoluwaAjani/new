select
    c.customer_id,
    cu.email,
    cv.cart_value
from {{ref('int_check_order')}} c
join {{ref('int_cart_value')}} cv
    on cv.customer_id = c.customer_id
   and cv.session_id = c.last_session_id
join {{ref('dim_customer')}} cu
    on cu.customer_id = c.customer_id
