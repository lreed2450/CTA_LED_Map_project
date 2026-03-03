SELECT l.id, 
l.next_stop_id, s.stop_name,
l.next_station_parent_id, s.station_descriptive_name,
l.train_line_name, 
l.direction_id, d.train_direction_name, 
s.cardinal_direction_id,
l.arrival_time, l.prediction_time, l.is_app
FROM dev.fct_lapi_data l
LEFT JOIN dev.dim_directions d on d.id = l.direction_id
LEFT JOIN dev.dim_stops s on s.stop_id = l.next_stop_id
where l.train_line_name <> 'Test'
ORDER BY l.id;