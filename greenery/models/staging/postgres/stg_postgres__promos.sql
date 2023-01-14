with promos as (select * from {{ source('postgres','promos') }} )
select promo_id as promo_name
     , discount as discount_amount
     , status   as promo_status
from promos