## Week 1 Questions 

# 1. Overall Conversion Rate: 0.624567
QUERY: 

```SQL
select sum(total_checkout_events)/sum(total_sessions) 
from DEV_DB.DBT_CARLMELLOWGMAILCOM.fact_user_sessions
```

# 2. Conversion Rate By Product 

```SQL
select 
 product_name
,sum(checkout_event_count) as total_purchase_sessions
, sum(total_sessions) as total_all_sessions 
, total_purchase_sessions/total_all_sessions
from DEV_DB.DBT_CARLMELLOWGMAILCOM.fact_product_sessions sessions 
left join dev_db.dbt_carlmellowgmailcom.stg_postgres__products products
on products.product_id = sessions.product_id
group by 1
order by 1 
```


