WITH source AS (
    SELECT * FROM {{ source('cta_source', 'src_direction_metadata') }}

)

SELECT *
FROM source