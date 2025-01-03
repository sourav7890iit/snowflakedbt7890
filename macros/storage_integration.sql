{%- macro create_s3_integration(integration_name, role_arn, locations) -%}
{%- set sql -%}
 begin;

 -- Create stage
 create or replace storage integration {{ integration_name }}
   type = external_stage
   storage_provider = s3
   enabled = true
   storage_aws_role_arn = '{{ role_arn }}'
   storage_allowed_locations = (
     {%- for loc in locations %}
     '{{ loc }}'{% if not loop.last %},{% endif %}
     {%- endfor %}
   );

 commit;
 {%- endset -%}

 {%- do log(sql, info=True) -%}
 {%- do run_query(sql) -%}
 {%- do log("S3 integration created", info=True) -%}
 {%- set results = run_query("desc integration " + integration_name) -%}
 {%- do results.print_table(max_column_width=200) -%}
 {%- endmacro -%}