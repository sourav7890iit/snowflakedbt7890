select * from {{ source('snowflake_raw_src', 'raw_customers') }}