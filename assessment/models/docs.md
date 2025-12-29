{% docs int_session %}
The `int_session` model groups customer events into sessions.

A session is defined as a continuous sequence of events for a single customer with no more than 30 minutes of inactivity between consecutive events.
Session IDs are generated sequentially per customer by identifying inactivity
gaps between chronologically ordered events.

{% enddocs %}


{% docs int_last_session_per_customer %}
The `int_last_session_per_customer` model identifies the most recent session
for each customer by selecting the maximum session ID.

{% enddocs %}


{% docs int_session_bounds %}
The `int_session_bounds` model derives start and end timestamps for each customer session.

{% enddocs %}

{% docs int_check_order %}
The `int_check_order` model identifies orders placed by customers in their most recent session.
Only orders with `created_at` timestamps falling within the customer's last session are included.

{% enddocs %}


{% docs int_cart_value %}
The `int_cart_value` model calculates the total value of items added to the cart for each customer session.
For each customer and session, the model sums the `price` of all products
where the event type is `'ADD_PRODUCT_TO_CART'`.

### Usage
- Supports session-level cart analytics
- Enables calculation of average cart value per session

{% enddocs %}
