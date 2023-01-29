with dim_users as (select * from {{ ref('dim_users')}})
,   fct_orders as (select * from {{ ref('fact_orders')}})
select dim_users.user_id
     , zeroifnull(count(order_id))          as total_orders
     , zeroifnull(sum(order_total))         as total_spend
     , zeroifnull(sum(total_item_quantity)) as total_items
     , zeroifnull(sum(is_late_delivery::int))    as total_late_deliveries
     , zeroifnull(sum(is_promo_order::int)) as total_promo_orders
from dim_users
     left join fct_orders
               on dim_users.user_id = fct_orders.user_id
group by dim_users.user_id 