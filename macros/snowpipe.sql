{%- macro
create_pipe(pipe_name,schema_name,table_name,stage_name,
integration_name,s3_url,columns,file_type,pattern_value) -%}
 {%- set sql -%}
 begin;
 -- Create schema
 create schema if not exists {{ schema_name }};

 -- Create stage
 create or replace stage {{ schema_name }}.{{ stage_name }}
   storage_integration = {{ integration_name }}
   url = "{{ s3_url }}";

 -- Create table
 create or replace table {{ schema_name }}.{{ table_name }} (
   {%- for col, type in columns.items() %}
   {{ col }} {{ type }}{% if not loop.last %},{% endif %}
   {%- endfor %}
 );

-- Create pipe
 create or replace pipe {{ schema_name }}.{{ pipe_name }} auto_ingest = true as
   copy into {{ schema_name }}.{{ table_name }}
   from @{{ schema_name }}.{{ stage_name }}/unload_table/
   pattern={{pattern_value}}
   on_error = continue
    file_format = (
     type = {{ file_type }}
     {%- if file_type == 'CSV' %}
       skip_header = 1
       field_optionally_enclosed_by = '"'
     {% endif -%}
     null_if = ('')
   );

 commit;
 {%- endset -%}

 {%- do log(sql, info=True) -%}
 {%- do run_query(sql) -%}
 {%- do log("Auto-ingest pipe created", info=True) -%}
 {%- endmacro -%}

