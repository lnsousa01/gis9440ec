with customers as (

     select * from {{ ref('stg_jaffle_shop__customers') }}

),

orders as ( 

    select * from {{ ref('stg_jaffle_shop__orders') }}

),

payments as (

    select * from {{ref('stg_stripe__payments')  }}

),

customer_orders as (

    select
        customer_id,
        min(order_date) as first_order_date,
        max(order_date) as most_recent_order_date,
        count(order_id) as number_of_orders

    from orders

    group by 1

),
lifetime_value as (
    select sum(amount) as lifetime_value, 
    order_id 
    from payments
    group by order_id
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
        lifetime_value.lifetime_value

    from customers
    left join orders using (customer_id)
    left join customer_orders using (customer_id)
    left join lifetime_value using (order_id)

)

select * from final