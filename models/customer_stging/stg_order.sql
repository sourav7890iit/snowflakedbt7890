with a as (
select * from {{ source('snowflake_raw_src', 'raw_orders') }}
),
final as (
select id as ORDER_ID,
USER_ID,ORDER_DATE,STATUS from a 
)
select * from final