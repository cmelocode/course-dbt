
{%- set event_types = dbt_utils.get_column_values(
    table=ref('stg_postgres__events'),
    column='event_type'
) -%}

with session_events as (select * from {{ ref('stg_postgres__events') }})
, session_events_agg as 
(
  select user_id
      , session_id
      {%- for event_type in event_types %}
      , {{ case_when_agg('event_type',event_type ) }} as {{event_type}}_event_count
      {% endfor %}
      , min(created_at_utc) as first_session_event_at_utc
      , max(created_at_utc) as last_session_event_at_utc
      , count(event_id)     as total_event_count
      {%- for event_type in event_types %}
      , case when  {{event_type}}_event_count>0 then TRUE else FALSE end as has_{{event_type}}_event
      {% endfor %}
  from session_events
  group by user_id, session_id
)
select * from session_events_agg