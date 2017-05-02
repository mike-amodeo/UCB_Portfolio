Directory containing queries of weather-related metrics. The shell file runs all sql files in Hive.

Execution Instructions:
1. ./weather_investigations.sh
2. python weather_forecast.py

Files:

1. weather_investigations.sh - Executable shell file that runs all of the queries contained in this subfolder and exports output as tab separated value files to /flight_app/final_csv directory
2. weather_queries.sql - initial queries related to weather data linking flight data to weather data
weather_delay_queries.sql - Additional queries calculating likelihood of delays at individual airports and other items
3. Q1_precip_days_ann.sql - Query that creates first weather metric, a table of the 25 busiest airports with the average days of precipitation over study period
4. Q2_likelihood_month.sql - Query of the second weather metric, table of the likelihood of weather delay per airport per month
5. Q3_likelihood_based_on_depth.sql - Query of the third weather metric, table of the likelihood of a delay given a depth of precipitation
6. weather_forecast.py - Python script that connects to a Weather Underground API to access 10 day forecasts for the 25 busiest US airports. The depth of rainfall per day is then compared against the historical data and likelihood of delays generated for previous queries to estimate the number of delays at each airport for each of the next 10 days.

