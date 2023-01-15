with order_items as (select * from {{ source('postgres', 'order_items') }} )
select {{ dbt_utils.generate_surrogate_key(['order_id' ,'product_id']) }} as  order_item_id
     , order_id
     , product_id
     , quantity
from order_items