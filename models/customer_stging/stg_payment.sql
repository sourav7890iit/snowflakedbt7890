with a as (
select * from {{ source('snowflake_raw_src', 'raw_payments') }}
),
final as (
select id as PAYMENT_ID,
ORDER_ID,
PAYMENT_METHOD AS PAYMENT_MODE,
AMOUNT/100 AS SALES_AMOUNT from a 
)
select * from final