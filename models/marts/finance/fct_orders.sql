WITH 
orders AS(
    select order_id, customer_id
    FROM dbt-extra-credit.dbt_lsousa2.stg_jaffle_shop__orders
),
amount AS(
    SELECT amount
    FROM dbt-extra-credit.dbt_lsousa2.stg_stripe__payments
),
final AS(
    SELECT * FROM orders LEFT JOIN amount ON order_id)
SELECT * FROM final