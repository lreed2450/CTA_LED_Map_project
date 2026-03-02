SELECT *
from raw.src_stop_metadata;

SELECT l.id, l.train_line_name, 
l.train_direction_id, d.train_direction_name, 
s."DIRECTION_ID" as "cardinal_direction_id",
l.next_station_parent_id,
s."STATION_DESCRIPTIVE_NAME" AS "next_station_parent_descriptive_name",
l.next_stop_id, s."STOP_NAME" AS "next_stop_descriptive_name",
l.arrival_time, l.prediction_time, l.is_app, l.is_delayed
FROM raw.src_lapi_data l
LEFT JOIN raw.src_stop_metadata s
ON l.next_stop_id = s."STOP_ID"
LEFT JOIN raw.src_direction_metadata d  
ON d.train_line_name = l.train_line_name
AND d.train_direction_id = l.train_direction_id
WHERE l.train_line_name not like 'test'
ORDER BY l.id;

select DISTINCT train_line_name
from raw.src_lapi_data
where train_line_name not like 'test'
ORDER BY train_line_name;
