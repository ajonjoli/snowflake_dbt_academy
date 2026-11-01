{#
/*{{ 
    codegen.generate_source(
        schema_name = 'public',
        database_name = 'raw',
        name = 'src_public',
        include_database = True,
        include_schema = True
    )
}}
#}
{#
{{
    codegen.generate_base_model(
        source_name = 'raw_data',
        table_name = 'customers',
        materialized = 'view'
    )
}}
#}
-- dbt run-operation generate_base_model --args '{"source_name": "raw_data", "table_name": "customers"}'
-- dbt run-operation codegen.create_base_models --args '{"source_name": "raw_data", "tables": ["orders", "payments", "products"]}'
