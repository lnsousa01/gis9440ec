WITH 
orders AS(
    select order_id, customer_id
    FROM stg_jaffle_shop__orders
),
amount AS(
    SELECT amount
    FROM stg_stripe__payments
),
final AS(
    SELECT * FROM orders LEFT JOIN amount ON order_id)
SELECT * FROM final