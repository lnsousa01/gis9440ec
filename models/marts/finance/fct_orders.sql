WITH 
orders AS(
    --change select statement to include everything in the table:
    select *
    FROM dbt-extra-credit.extracreditproject.stg_jaffle_shop__orders
),
--change alias for "stripe__payments" table:
payments AS(
    --change select statement to include everything in the table:
    SELECT *
    FROM dbt-extra-credit.extracreditproject.stg_stripe__payments
),
--create order_payments table to filter for orders that did go through:
order_payments AS(
    select order_id, 
    sum(
        case 
            when status = 'success' then amount 
        end) as amount
    from payments 
    group by 1
),
--change selections for "final" cte table
final AS(
    SELECT 
        orders.order_id,
         orders.customer_id,
         orders.order_date,
         coalesce (order_payments.amount,0) as amount
         FROM orders LEFT JOIN order_payments USING (order_id))
SELECT * FROM final