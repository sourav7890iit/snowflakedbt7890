with customer as (
select * from {{ ref('stg_customer') }}
),
orders as (
select * from {{ ref('stg_order') }}
),
payments as (
select * from {{ ref('stg_payment') }}
),
customer_level_details as (
select c.first_name,c.last_name,c.customer_id,min(o.order_date) as first_order,
max(o.order_date) as most_recent_order 
from customer c
left join orders o
on c.customer_id=o.user_id
group by c.first_name,c.last_name,c.customer_id
),
payment_details as (
select o.user_id as customer_id,sum(p.sales_amount) as amount
from payments p
left join orders o
on p.order_id=o.order_id
group by customer_id
),
final_tbl as (
select cl.first_name,cl.last_name,
cl.customer_id,cl.first_order,
cl.most_recent_order,pl.amount from customer_level_details cl 
left join payment_details pl
on cl.customer_id=pl.customer_id
)
select * from final_tbl