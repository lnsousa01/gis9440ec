SELECT
id as payment_id,
orderid as order_id,
paymentmethod as payment_method,
status,
amount,
created
FROM dbt-tutorial.stripe.payment