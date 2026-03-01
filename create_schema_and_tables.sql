CREATE SCHEMA raw;

CREATE TABLE IF NOT EXISTS raw.src_stop_metadata(  
    STOP_ID                     INT NOT NULL PRIMARY KEY,
    DIRECTION_ID                VARCHAR(1),
    STOP_NAME                   VARCHAR(30),
    STATION_NAME                VARCHAR(30),
    STATION_DESCRIPTIVE_NAME    VARCHAR(40),
    MAP_ID                      INT,
    ADA                         BOOLEAN,
    RED                         BOOLEAN,
    BLUE                        BOOLEAN,
    G                          BOOLEAN,
    BRN                         BOOLEAN,
    P                           BOOLEAN,
    Y                           BOOLEAN,
    Pnk                         BOOLEAN,
    O                           BOOLEAN,
    Location                    VARCHAR(40)
);


-- all data from lapi initially loads as strings
CREATE TABLE IF NOT EXISTS raw.src_lapi_data(  

    id                          SERIAL PRIMARY KEY,
    next_station_parent_id      VARCHAR(10),
    next_stop_id                VARCHAR(10),
    arrival_time                VARCHAR(30),
    prediction_time             VARCHAR(30),
    is_app                      VARCHAR(1),
    is_delayed                  VARCHAR(1)
);