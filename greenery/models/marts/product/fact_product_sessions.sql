
{%- set event_types = dbt_utils.get_column_values(
    table=ref('stg_postgres__events'),
    column='event_type'
) -%}

with session_events as (select * from {{ ref('stg_postgres__events') }})
, session_events_agg as 
(
  select coalesce(se.product_id, oi.product_id) as product_id
      , count(distinct session_id) as total_sessions
      {%- for event_type in event_types %}
      , {{ case_when_agg('event_type',event_type ) }} as {{event_type}}_event_count
      {% endfor %}
      , min(created_at_utc) as first_session_event_at_utc
      , max(created_at_utc) as last_session_event_at_utc
      , count(event_id)     as total_event_count
  from session_events se 
  left join stg_postgres__order_items oi 
    on oi.order_id = se.order_id 
  group by  coalesce(se.product_id, oi.product_id) 
)
select * from session_events_agg