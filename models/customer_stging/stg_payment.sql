with a as (
select * from {{ source('snowflake_raw_src', 'raw_payments') }}
),
final as (
select id as PAYMENT_ID,
ORDER_ID,PAYMENT_METHOD,AMOUNT from a 
)
select * from final