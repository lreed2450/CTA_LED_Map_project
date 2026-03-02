# README

This repository is for writing the code necessary to connect to the CTA Location API and light up LED lights in a map corresponding to the real-time location of the trains.

---
### General Flow of project
1. pull data from location API
    * https://www.transitchicago.com/assets/1/6/cta_Train_Tracker_API_Developer_Guide_and_Documentation.pdf
    * create df with cols train_line_name, train_direction_id, next_station_parent_id, next_stop_id, arrival_time, prediction_time, is_app, is_delayed
    * create two additional tables for stop and train direction metada
        * stop metadata: stop_id, direction_id, stop_name, station_name, station_descriptive_name, map_id, ada, red, blue, g, brn, p, y, pnk, o, location
            * https://data.cityofchicago.org/Transportation/CTA-System-Information-List-of-L-Stops/8pix-ypme/about_data

        * direction metadata: train_line_name, train_direction_id, train_direction_name
            * comes from lapi documentation
    * load tables to local postgres cta_data database
2. transform data with dbt and automate pulling data from API with airflow
    * **note:** WIP currently building out dbt
    * rename columns w AS
    * clean up dtypes w CAST
    * generate surrogate keys
    * correctly map primary and foreign keys in schema .yml file
    * format datetime to `9999-12-31 23:59:59` format is currently `2026-03-01T12:35:27`
    * main dbt commands: dbt init, dbt run, dbt test
3. pull data from clean tables and build...
    * machine learning model to predict when trains will arrive at each stop based on the time of data
    * map lapi data to GPIO pins on rasberry pi 
---
tech stack: python, sql, postgres, dbt, git, github, apache airflow

vscode extensions: Better Jinja, Database Client JDBC, dbt formatter, Power User for dbt, vscode-dbt, PostgreSQL, Jupyter, Jupyter Notebook Renders v1.3.0, Jupyter Keymap, Python Environments

---
project structure: TBD


---
### useful documentation:
* cta location api: https://www.transitchicago.com/assets/1/6/cta_Train_Tracker_API_Developer_Guide_and_Documentation.pdf
* stop metadata: https://data.cityofchicago.org/Transportation/CTA-System-Information-List-of-L-Stops/8pix-ypme/about_data
* direction metadata: found in Appendix C of location api docs
* dbt docs: https://docs.getdbt.com/docs/build/documentation
* dbt notes: https://publish.obsidian.md/datavidhya/Course+Notes/Fundamentals+of+Data+Engineering

* installing postgresql on linux mint with pgadmin: https://www.tecmint.com/install-postgresql-with-pgadmin4-on-linux-mint/

* inspiration: https://imgur.com/gallery/diy-live-cta-map-css6Twu