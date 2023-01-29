with order_items  as  (select * from {{ ref ('stg_postgres__order_items')}} )
select order_id
, count(distinct product_id) as distinct_product_count
, sum(quantity)              as total_item_quantity 
from order_items
group by order_id  