# README

This repository is for writing the code necessary to connect to the CTA Location API and light up LED lights in a map corresponding to the real-time location of the trains.

---

### high level project flow

overall orchestrator: airflow
1. run `get_half_trns_lapi_call()`
2. delete all rows from 1 of 2 temp half lapi data
3. write df to 2 of 3 raw tables in local postgres cta_data databse
     * tables:  _all_ src_lapi data, temp first half lapi, temp second half lapi
4. run dbt
5. pull _all_ fresh data from 1 of 2 temp lapi tables
6. map temp data to GPIO pins and LED lights
7. wait ~2 minutes
8. run 1-6 again on second half of lapi data writing to other temp table
9. repeat 7-8

---

### detailed flow of project
1. pull data from location API
    * https://www.transitchicago.com/assets/1/6/cta_Train_Tracker_API_Developer_Guide_and_Documentation.pdf
    * create df with cols `train_line_name`, `train_direction_id`, `next_station_parent_id`, `next_stop_id`, `arrival_time`, `prediction_time`, `is_app`, `is_delayed`
    * create two additional tables for stop and train direction metada
        * stop metadata: `stop_id`, `direction_id`, `stop_name`, `station_name`, `station_descriptive_name`, `map_id`, `ada`, `red`, `blue`, `g`, `brn`, `p`, `y`, `pnk`, `o`, `location`
        * https://data.cityofchicago.org/Transportation/CTA-System-Information-List-of-L-Stops/8pix-ypme/about_data

        * direction metadata: train_line_name, train_direction_id, train_direction_name
        * found in Appendix C of location api docs
    * load tables to local postgres cta_data database
2. transform data with dbt and automate pulling data from API with airflow

    * **note:** WIP currently building out airflow automation
    * rename columns w AS
    * clean up dtypes w CAST
    * map lapi train_line_name and direction_id to new id column of direction table
    * rename train lines to remove abbrevations
    * correctly map primary and foreign keys in schema .yml file
    * format datetime to `9999-12-31 23:59:59` format is currently `2026-03-01T12:35:27`

3. pull data from clean tables and build...
    * machine learning model to predict when trains will arrive at each stop based on the time of data
    * map lapi data to GPIO pins on rasberry pi 
---
**tech stack:** python, sql, postgres, dbt, git, github, apache airflow

**vscode extensions:** Better Jinja, Database Client JDBC, dbt formatter, Power User for dbt, vscode-dbt, PostgreSQL, Jupyter, Jupyter Notebook Renders v1.3.0, Jupyter Keymap, Python Environments 

---

**main dbt commands:** dbt init, dbt run, dbt test
    * initialize dbt directory with `dbt init <my_dir_name>` and follow prompts
    * after set up run `dbt debug` if there are errors make changes to `profiles.yml`

---

---
### Bugs

1. issues with serial primary key when creating `src_lapi_data`
    * problem: writing df from `get_half_trns_lapi_call()` to database table wouldn't create id column but after adding test value it worked
    * temp fix: loaded 1 test record to start serial IDs before loading in data
2. issue with keys
    * problem: keys are mapped in `schema.yml` but don't show up mapped as keys when connected to database
    * temp fix: (WIP) create index during dbt
3. dbt test fails for stg_stops
    * problem: tests fial because column `stop_id` doesn't exist
    * temp fix: ... delete tests... or ignore errors

---
### useful documentation:
* cta location api: https://www.transitchicago.com/assets/1/6/cta_Train_Tracker_API_Developer_Guide_and_Documentation.pdf
* stop metadata: https://data.cityofchicago.org/Transportation/CTA-System-Information-List-of-L-Stops/8pix-ypme/about_data
* direction metadata: found in Appendix C of location api docs
* dbt docs: https://docs.getdbt.com/docs/build/documentation
* dbt notes: https://publish.obsidian.md/datavidhya/Course+Notes/Fundamentals+of+Data+Engineering
* airflow fundamentals: https://airflow.apache.org/docs/apache-airflow/stable/tutorial/fundamentals.html
* airflow example pipeline: https://airflow.apache.org/docs/apache-airflow/stable/tutorial/pipeline.html

* installing postgresql on linux mint with pgadmin: https://www.tecmint.com/install-postgresql-with-pgadmin4-on-linux-mint/

* inspiration: https://imgur.com/gallery/diy-live-cta-map-css6Twu