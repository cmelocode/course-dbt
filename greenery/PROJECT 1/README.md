## Week 1 Questions 

# 1. How many users do we have? 130 users 
QUERY: 

```SQL
select count(distinct user_id)from DEV_DB.DBT_CARLMELLOWGMAILCOM.STG_POSTGRES__USERS
```

# 2. On average, how many orders do we receive per hour?

7.68 orders per hour 

```SQL

 with hours as (
    select datediff('hour',min(created_at_utc), max(created_at_utc )) as total_hours from DEV_DB.DBT_CARLMELLOWGMAILCOM.STG_POSTGRES__ORDERS
)
    ,orders as (
select count(distinct order_id) as order_count from DEV_DB.DBT_CARLMELLOWGMAILCOM.STG_POSTGRES__ORDERS
        ) 
        select order_count/total_hours from orders
        join hours;
```


# 3. On average, how long does an order take from being placed to being delivered?
    
    93.4 hours or ~ 4 days 

```SQL
with a as (
select created_at_utc,delivered_at_utc, datediff('hour', created_at_utc, delivered_at_utc) as hours_to_delivery
from DEV_DB.DBT_CARLMELLOWGMAILCOM.STG_POSTGRES__ORDERS
) 
select AVG(hours_to_delivery) from a;
```


# 4. How many users have only made one purchase? Two purchases? Three+ purchases?

Num orders| count_users 
1	      | 25
2	      | 28
3+	      | 71

```SQL
with orders_per_user as (
select user_id, count(distinct order_id) as num_orders from DEV_DB.DBT_CARLMELLOWGMAILCOM.STG_POSTGRES__ORDERS
group by user_id
) 
select 
case when num_orders>=3 then '3+'
else num_orders::string end
, count(user_id) from orders_per_user
group by 1
order by 1 asc;

```

# 5. Q: On average, how many unique sessions do we have per hour? 

A: 10.14 sessions per hour 
```SQL
select count(distinct session_id) as distinct_sessions
, max(created_at_utc) max_h
, min(created_at_utc) min_h
,datediff('hour',min_h,max_h) as total_hours
, distinct_sessions/total_hours sessions_per_hour
from DEV_DB.DBT_CARLMELLOWGMAILCOM.STG_POSTGRES__EVENTS;
```