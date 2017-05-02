#!/bin/bash

# Run all weather related queries in hive
hive -f weather_queries.sql
hive -f weather_delay_queries.sql
hive -f Q1_precip_days_ann.sql
hive -f Q2_likelihood_month.sql
hive -f Q3_likelihood_based_on_depth.sql

# Export metric query results to tsv files for use in R dashboard
hive -e 'set hive.cli.print.header=true; select * from Q1_precip_days' | sed 's/[\t]/,/g' > Q1_precip_days_ann.csv
hive -e 'set hive.cli.print.header=true; select * from likelihood_monthly_pivot' | sed 's/[\t]/,/g' > Q2_likelihood_month.csv
hive -e 'set hive.cli.print.header=true; select * from delay_depth' | sed 's/[\t]/,/g' > Q3_likelihood_based_on_depth.csv

# Move files to appropriate location
cd ..
mv weather_investigation/Q1_precip_days_ann.csv flight_app/final_csv/Q1_precip_days_ann.csv
mv weather_investigation/Q2_likelihood_month.csv flight_app/final_csv/Q2_likelihood_month.csv
mv weather_investigation/Q3_likelihood_based_on_depth.csv flight_app/final_csv/Q3_likelihood_based_on_depth.csv

