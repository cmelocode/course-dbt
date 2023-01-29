with orders as (select * from {{ ref('stg_postgres__orders') }} )
, item_agg  as (select * from  {{ ref('imd_order_items_agg_to_order') }} )
select orders.order_id
     , orders.user_id
     , orders.promo_name
     , orders.address_id
     , orders.created_at_utc
     , orders.order_cost
     , orders.shipping_cost
     , orders.order_total
     , item_agg.distinct_product_count
     , item_agg.total_item_quantity
     , orders.tracking_id
     , orders.shipping_service
     , orders.estimated_delivery_at_utc
     , orders.delivered_at_utc
     , orders.order_status
     , orders.delivered_at_utc > orders.estimated_delivery_at_utc       as is_late_delivery
     , datediff('hour', orders.created_at_utc, orders.delivered_at_utc) as total_hours_to_delivery
     , orders.promo_name is not null as is_promo_order 
from orders
     left join item_agg
               on orders.order_id = item_agg.order_id 