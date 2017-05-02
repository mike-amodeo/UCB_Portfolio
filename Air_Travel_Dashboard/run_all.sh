#!/bin/bash

# Load Flight Data
# Save current directory
MY_CWD=$(pwd)

# Step 1: Download Flight Data and Load to HDFS
cd load_flight_data

chmod u+x,g+x load_flight_data.sh
./load_flight_data.sh

cd $MY_CWD

# Step Two: Transform flight data in Hive
cd transform_flight_data

# Load flight data into Hive
hive -f load_2007_2016.sql

echo "Flight Data Loaded"

# Combine monthly data to annual
hive -f months_to_years.sql

# Create five year blocks of data
hive -f one_to_five_years.sql

# Remove flight data from HDFS to free up space
chmod u+x,g+x flight_data_HDFS_cleanup.sh
./flight_data_HDFS_cleanup.sh

# Merge yearly data
hive -f all_years.sql

# Remove monthly files to leave just yearly and 5 year blocks
hive -f cleanup_months.sql

echo "Flight Data Transformed"

cd $MY_CWD

#Step 3: Run Air travel queries
cd airline_eda

#Create tables for Hive queries
hive -f tables_for_csv_export.sql

#Run queries to create CSVs to be saved for dashboard
./final_csv_export.sh

echo "Flight Metrics Queried and Exported"

#Step 4: Load Weather Data
cd $MY_CWD

cd weather_data

#Load to HDFS
chmod u+x,g+x load_weather_data.sh
./load_weather_data.sh

echo "Weather Data Loaded"

#Load to Hive and transform
hive -f hive_weather_data_import.sql
hive -f hive_weather_merge.sql

echo "Weather Data Transformed"

cd $MY_CWD

#Step 5: Run Weather Investigation Queries
cd weather_investigation
chmod u+x,g+x weather_investigations.sh
./weather_investigations.sh

cd $MY_CWD

python weather_investigation/weather_forecast.py

echo "Weather Data Queried and Exported"

# Remove weather data from HDFS to free up space
cd weather_data

chmod u+x,g+x weather_data_cleanup.sh
./weather_data_cleanup.sh

cd $MY_CWD


