with session_events as (select * from {{ ref('stg_postgres__events') }})
, session_events_agg as 
(
  select user_id
      , session_id
      , sum(case when event_type = 'add_to_cart' then 1 else 0 end) as add_to_cart_event_count
      , sum(case when event_type = 'checkout' then 1 else 0 end) as checkouts_event_count
      , sum(case when event_type = 'package_shipped' then 1 else 0 end) as package_shipped_event_count
      , sum(case when event_type = 'page_view' then 1 else 0 end) as page_view_event_count
      , min(created_at_utc) as first_session_event_at_utc
      , max(created_at_utc) as last_session_event_at_utc
      , count(event_id)     as total_event_count
  from session_events
  group by user_id, session_id 
)
select * from session_events_agg