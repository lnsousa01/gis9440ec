WITH 
orders AS(
    select order_id, customer_id
    FROM dbt-extra-credit.extracreditproject.stg_jaffle_shop__orders
),
amount AS(
    SELECT amount, order_id
    FROM dbt-extra-credit.extracreditproject.stg_stripe__payments
),
final AS(
    SELECT * FROM orders LEFT JOIN amount USING (order_id))
SELECT * FROM final