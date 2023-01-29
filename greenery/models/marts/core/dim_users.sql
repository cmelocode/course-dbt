with users as (select * from {{ ref('stg_postgres__users') }} )
, address  as  (select * from {{ ref ('stg_postgres__addresses')}})
select users.user_id
     , users.first_name
     , users.last_name
     , users.email
     , users.phone_number
     , users.created_at_utc
     , users.updated_at_utc
     , users.address_id
     , address.address
     , address.zipcode
     , address.state_name
     , address.country_name
from users
     left join address
               on address.address_id = users.address_id 