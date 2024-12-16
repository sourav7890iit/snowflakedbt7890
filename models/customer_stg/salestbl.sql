with a as (select *,{{percent_change('SALES','SALES2')}} as change1,
{{percent_change('SALES2','SALES3')}} as change2,
{{percent_change('sales3','cost')}} as change3,
from {{ ref('sales') }}),
b as (select *,{{calculate_values('change2','change1','change3')}} as total_changes from a)
select * from b