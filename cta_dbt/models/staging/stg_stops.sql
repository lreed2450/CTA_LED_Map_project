WITH source AS (
    SELECT * FROM {{ source('cta_source', 'src_stop_metadata') }}

)

SELECT *
FROM source