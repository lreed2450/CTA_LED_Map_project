WITH stage AS (
    SELECT * FROM {{ ref("stg_lapi") }}

)

SELECT id,

CASE WHEN train_line_name = 'brn' THEN 'Brown'
    WHEN train_line_name = 'g' THEN 'Green'
    WHEN train_line_name = 'org' THEN 'Orange'
    WHEN train_line_name = 'p' THEN 'Purple'
    WHEN train_line_name = 'y' THEN 'Yellow'
    ELSE INITCAP(train_line_name)
    END AS train_line_name,

CASE WHEN train_line_name = 'blue' AND train_direction_id = 1 THEN 1
    WHEN train_line_name = 'blue' AND train_direction_id = 5 THEN 2
    WHEN train_line_name = 'y' AND train_direction_id = 1 THEN 3
    WHEN train_line_name = 'y' AND train_direction_id = 5 THEN 4
    WHEN train_line_name = 'brn' AND train_direction_id = 1 THEN 5
    WHEN train_line_name = 'brn' AND train_direction_id = 5 THEN 6
    WHEN train_line_name = 'p' AND train_direction_id = 1 THEN 7
    WHEN train_line_name = 'p' AND train_direction_id = 5 THEN 8
    WHEN train_line_name = 'pink' AND train_direction_id = 1 THEN 9
    WHEN train_line_name = 'pink' AND train_direction_id = 5 THEN 10
    WHEN train_line_name = 'g' AND train_direction_id = 1 THEN 11
    WHEN train_line_name = 'g' AND train_direction_id = 5 THEN 12
    WHEN train_line_name = 'red' AND train_direction_id = 1 THEN 13
    WHEN train_line_name = 'red' AND train_direction_id = 5 THEN 14
    WHEN train_line_name = 'org' AND train_direction_id = 1 THEN 15
    WHEN train_line_name = 'org' AND train_direction_id = 5 THEN 16
    ELSE NULL
    END AS direction_id,
    
next_station_parent_id,
next_stop_id,

CAST(REPLACE(arrival_time,'T', ' ') AS TIMESTAMPTZ) as arrival_time,
CAST(REPLACE(prediction_time,'T', ' ') AS TIMESTAMPTZ) as prediction_time,

is_app,
is_delayed
FROM stage