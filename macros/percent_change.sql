{% macro percent_change(val1,val2) %}
(({{val1}}-{{val2}})/{{val2}})*100
{% endmacro %}