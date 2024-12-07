with customers as (
     select * from {{ ref('stg_jaffle_shop__customers') }}
),
orders as ( 

    select * from {{ ref('stg_jaffle_shop__orders') }}
),
--remove payments table selection
customer_orders as (
    select
        customer_id,
        min(order_date) as first_order_date,
        max(order_date) as most_recent_order_date,
        count(order_id) as number_of_orders,
    --calculate lifetime value from orders table:
        sum(amount) as lifetime_value

    from orders
    group by 1
),
--remove lifetime_value cte table that depended on payments table
),
final as (
    select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        customer_orders.first_order_date,
        customer_orders.most_recent_order_date,
        coalesce (customer_orders.number_of_orders, 0) 
        as number_of_orders,
        --change lifetime value selection to new column:
        customer_orders.lifetime_value
    from customers
    --remove orders and lifetime_value joins as they are now irrelevant:
    left join customer_orders using (customer_id)
)
select * from final