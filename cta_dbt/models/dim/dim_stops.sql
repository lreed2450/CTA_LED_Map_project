WITH stage AS (
    SELECT * FROM {{ ref('stg_stops') }}

)

SELECT
"STOP_ID" AS stop_id,
"DIRECTION_ID" AS cardinal_direction_id,
"STOP_NAME" AS stop_name,
"STATION_NAME" AS station_name,
"STATION_DESCRIPTIVE_NAME" AS station_descriptive_name,
"MAP_ID" as map_id,
"RED" as is_red,
"BLUE" as is_blue,
"G" as is_green,
"BRN" as is_brown,
"P" as is_purple,
"Y" as is_yellow,
"Pnk" as is_pink,
"O" as is_orange,
"Location" as location
FROM stage