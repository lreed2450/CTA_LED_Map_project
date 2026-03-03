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
    G                           BOOLEAN,
    BRN                         BOOLEAN,
    P                           BOOLEAN,
    Y                           BOOLEAN,
    Pnk                         BOOLEAN,
    O                           BOOLEAN,
    Location                    VARCHAR(40)
);


-- all data from lapi initially loads as strings
CREATE TABLE IF NOT EXISTS raw.src_lapi_data(  

    id                          SERIAL NOT NULL PRIMARY KEY,
    train_line_name             VARCHAR(10),
    train_direction_id          INT,
    next_station_parent_id      INT,
    next_stop_id                INT,
    arrival_time                VARCHAR(30),
    prediction_time             VARCHAR(30),
    is_app                      BOOLEAN,
    is_delayed                  BOOLEAN
);



CREATE Table IF NOT EXISTS raw.src_direction_metadata(

id                                   INT,
train_line_name              VARCHAR(15),
train_direction_id              SMALLINT,
train_direction_name          VARCHAR(20)

);


-- inserting because of issue w serial column when only loading df
-- hoping to fix ID and drop test row w dbt
INSERT into raw.src_lapi_data (train_line_name)
VALUES ('test');