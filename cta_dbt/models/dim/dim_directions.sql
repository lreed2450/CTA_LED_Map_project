WITH stage AS (
    SELECT * FROM {{ ref("stg_directions") }}

)

SELECT index AS Id,
CASE WHEN train_line_name = 'brn' THEN 'Brown'
    WHEN train_line_name = 'g' THEN 'Green'
    WHEN train_line_name = 'org' THEN 'Orange'
    WHEN train_line_name = 'p' THEN 'Purple'
    WHEN train_line_name = 'y' THEN 'Yellow'
    ELSE INITCAP(train_line_name)
    END AS train_line_name,

train_direction_id,
train_direction_name
FROM stage

