with addresses as (select * from {{ source('postgres', 'addresses') }} )
select address_id
     , address
     , zipcode
     , state   as state_name
     , country as country_name
from addresses