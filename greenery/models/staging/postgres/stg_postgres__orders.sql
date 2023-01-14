with src_orders as (select * from {{ source('postgres','orders')}})
select order_id
     , user_id
     , promo_id                             as promo_name
     , address_id
     , created_at::timestamp_ntz            as created_at_utc
     , order_cost
     , shipping_cost
     , order_total
     , tracking_id
     , shipping_service
     , estimated_delivery_at::timestamp_ntz as estimated_delivery_at_utc
     , delivered_at::timestamp_ntz          as delivered_at_utc
     , status                               as order_status
from src_orders