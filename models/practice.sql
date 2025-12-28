{{
    config(
        materialized='view'
    )
}}
select 1 as id, 'Sourav' as name 
union all
select 2 as id,'Das' as name