{{
    config(
        materialized='incremental'
    )
}}
with a as (select * from {{ source('snowflake_raw_src', 'dim_sales') }})
select *,row_number() over(order by sales desc) as rn from a

{% if is_incremental() %}
    -- this filter will only be applied on an incremental run
    where date > (select max(date) from {{ this }}) 
{% endif %}