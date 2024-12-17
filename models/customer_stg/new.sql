SELECT size,
{{ dbt_utils.get.pivot('color', dbt_utils.get_column_values(ref('example'), 'color')) }}
FROM ref('example')
GROUP BY size