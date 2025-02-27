with events as (select * from {{ source('postgres', 'events') }} )
select event_id
     , session_id 
     , user_id
     , page_url
     , created_at::timestamp_ntz as created_at_utc
     , event_type
     , order_id
     , product_id
from events 