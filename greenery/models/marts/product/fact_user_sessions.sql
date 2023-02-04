with session_agg as ( select * from {{ ref ('imd_session_events_agg')}})
select user_id
     , count(session_id)                as total_sessions
     , sum(total_event_count)           as total_events
     , sum(add_to_cart_event_count)     as total_add_to_cart_events
     , sum(checkout_event_count)        as total_checkout_events
     , sum(package_shipped_event_count) as total_package_shipped_events
     , sum(page_view_event_count)       as total_page_views
from session_agg
group by user_id