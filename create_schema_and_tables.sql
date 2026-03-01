CREATE SCHEMA raw;

CREATE TABLE raw.src_stop_metadata(  
    stop_id                     INT NOT NULL PRIMARY KEY,
    direction_id                VARCHAR(1),
    stop_name                   VARCHAR(30),
    station_name                VARCHAR(30),
    station_descriptive_name    VARCHAR(40),
    map_id                      INT,
    ada                         BOOLEAN,
    red                         BOOLEAN,
    blue                        BOOLEAN,
    g                           BOOLEAN,
    brn                         BOOLEAN,
    p                           BOOLEAN,
    y                           BOOLEAN,
    pnk                         BOOLEAN,
    o                           BOOLEAN,
    location                    VARCHAR(40)
);


-- all data from lapi initially loads as strings
CREATE TABLE raw.src_lapi_data(  

    id                          SERIAL PRIMARY KEY,
    next_station_parent_id      VARCHAR(10),
    next_stop_id                VARCHAR(10),
    arrival_time                VARCHAR(30),
    prediction_time             VARCHAR(30),
    is_app                      VARCHAR(1),
    is_delayed                  VARCHAR(1)
);