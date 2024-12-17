with a as (
select * from {{ source('snowflake_raw_src', 'raw_customers') }}
),
final as (
select id as CUSTOMER_ID,
FIRST_NAME,LAST_NAME from a 
)
select * from final