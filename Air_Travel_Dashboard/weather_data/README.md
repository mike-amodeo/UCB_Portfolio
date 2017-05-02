This directory contains several files to load base data into HDFS and a Postgres database through Hive.

Execution commands from terminal:
1. ./load_weather_data.sh
2. hive -f hive_weather_data_import.sql
3. hive -f hive_weather_merge.sql

Files

load_weather_data.sh - Executable shell file that downloads GHCN climate data by year starting in 2007, GHCN weather stations data file, and airports from BTS

stations_airports.py (do not execute) - Python script that matches airports with nearest weather station. Output from this file is included as CSV and referenced directly by other files. 

airports_stations.csv - Output from stations_airports.py script that includes airport ID and 3 letter code with the ID of nearest GHCN weather station

hive_weather_data_import.sql - Creates tables of annual weather data and airports with nearest weather station in Hive

hive_weather_merge.sql - Merges weather tables of years into a single table. Also creates a table of all precipitation that occurred at a station near an airport to be used for metric development

airports.csv - BTS file containing coordinates and codes for all airports internationally.
