WITH source AS (
    SELECT * FROM {{ source('cta_source', 'src_lapi_data') }}

)

SELECT * FROM source