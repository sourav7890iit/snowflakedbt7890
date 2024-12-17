with data as (
    SELECT 'S' as size, 'red' as color
    UNION ALL SELECT 'S' ,'blue'
    UNION ALL SELECT 'S', 'red'
    UNION ALL SELECT 'M', 'red'
)
SELECT * FROM data