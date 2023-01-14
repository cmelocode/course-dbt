with products as (select * from {{ source('postgres','products') }} )
select product_id
     , name      as product_name
     , price
     , inventory as inventory_count
from products 