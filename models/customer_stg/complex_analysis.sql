
{% set payment_modes = ['UPI', 'CASH', 'CC', 'DC', 'VOUCHER'] %}

select 
{% for i in payment_modes -%}
sum(case when payment_status = '{{ i }}' then sales end) as {{ i }}_SALES
{% if not loop.last %},
{% endif %}
{%- endfor -%}
from {{ source('source_practice', 'payments') }}

