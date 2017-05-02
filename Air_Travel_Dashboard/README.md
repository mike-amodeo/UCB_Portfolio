[Michael Alexander](https://github.com/malexander92), [Mike Amodeo](https://github.com/mike-amodeo), [Roseanna Hopper](https://github.com/r-hopper), [Yifan Sun](https://github.com/ysun1020)  
UC Berkeley MIDS W205 Data Storage and Retrieval  
Final Project Architecture  
April 24, 2017  

## Individual Contribution

My contribution to this project was primarily around the weather related analysis. This includes historical analysis of weather related delays joined to historical precipitation data as well as forecasted delays based on 10 day forecasted rainfall accessed through a Weather Underground API and compared against derived historical likelihood of delay given similar amounts of rainfall. As such, I have kept those files but not included the flight data files, created by other team members.

Also included here is a flow chart of the delay forecasting, as a file named "Delay Forecast Flowchart.png".

## Airline Data Dashboard  

We have created an airline data dashboard, hosted through R, which examines trends in U.S. flight data and weather from 2007 through 2016. This application downloads historical flight and weather data, uploads the data into a Hadoop Distributed File System (HDFS), loads the data into tables in Hive, queries the tables according to several custom defined metrics related to airport and flight performance, and exports the output of these metrics to an R-based dashboard that graphically displays the metrics.  

## Data Sources  

The Airline Data Dashboard application uses publicly available data from two federal government sources:
* Bureau of Transportation Statistics (BTS) Aviation Data Library - database of every flight departing or arriving from a United States airport with schedule and performance data. updated quarterly [https://www.transtats.bts.gov/](https://www.transtats.bts.gov/)  
* National Oceanographic and Atmospheric Administration (NOAA)  
    * Global Historical Climatology Network (GHCN) - daily weather data from land surface stations around the world with data as far back as 1763. updated daily [https://www.ncdc.noaa.gov/data-access/land-based-station-data/land-based-datasets/global-historical-climatology-network-ghcn](https://www.ncdc.noaa.gov/data-access/land-based-station-data/land-based-datasets/global-historical-climatology-network-ghcn)  
* Weather Underground: 10 day forecast data accessed through a custom API [https://www.wunderground.com/](https://www.wunderground.com/)  

## Execution Instructions  

Prerequisites: In order to replicate the results for this project, clone this directory in an EC2 instance. Due to the data being analyzed, we recommend that the instance be of **at least extra-large size**, with attached EBS storage of **at least 200 GB**. The execution also requires the following being set up prior to execution:  
* HDFS, Hive and Spark-SQL on EC2
* RStudio with markdown capabilities installed locally

Once an instance is set up and has both Hadoop and Postgres running, the application and all of its data can be replicated in either of two ways. First, it can be run by executing the run_all.sh shell file in the main directory of the repository. This will download all data, load to HDFS, and build and execute queries in Hive. Once complete, a user can open the file air_travel_dashboard.Rmd on their local machine with R installed, run the file, and view the output as an html file.  

Alternatively, the user can run the steps individually:  

1. Navigate to and execute /load_flight_data/load_flight_data.sh. This will call the shell file /load_flight_data/load_2007_2016.sh to download the flight data and store on the EC2 instance in a temporary directory. The file will also load the data to HDFS and clean up the temporary staging directory.  

2. Navigate to the folder /transform_flight_data and execute the following SQL files:  
    a. In Hive, run load_2007_2016.sql. This will load all of the files from 2007-2016 into Hive, separated by month.  
    b. Run months_to_years.sql. This will compile all of the separate monthly files by year.  
    c. Run one_to_five_years.sql, which will separate the full ten years into five-year blocks.  
    d. Run all_years.sql. This will compile all of the years into one table.  
    e. Run cleanup_months.sql in order to remove all of the individual month tables.  

3. Navigate to the folder /airline_eda and run tables_for_csv_export.sql in Hive or Spark-SQL before running final_csv_export.sh.  

4. Navigate to the folder /weather_data and perform the following steps:  
    a. Execute the file load_weather_data.sh to download all weather data and load into HDFS.  
    b. Execute hive_weather_data_import.sql in Hive to load the yearly weather data in Hive.  
    c. Execute hive_weather_merge.sql in Hive to merge all weather data.  

5. Navigate to the folder /weather_investigation and execute the file weather_investigations.sh. This file will perform the weather metrics queries on the tables in Hive and export tsv files to be used in the dashboard.  
    a. To run the last weather metric (10 day forecasted delays), navigate back up to the main directory of the repository and run the python script /weather_investigation/weather_forecast.py.  

6. Open R Studio on a local machine, and execute the file /flight_app/air_travel_dashboard.Rmd. This file will create an html file of the dashboard displaying all metrics. It references output files that are pre-loaded into the repo on Github. To view any replicated files, the files in the folder /flight_app/final_csv will need to be migrated by the user from the EC2 instance to the user’s local machine.  


## Dashboard Images

**Main page:**  
![Image of main page](https://github.com/mike-amodeo/UCB_Portfolio/blob/master/Air_Travel_Dashboard/flight_app/images/dashboard_main_page.png)


**Delay tab:**
![Image of delay tab](https://github.com/mike-amodeo/UCB_Portfolio/blob/master/Air_Travel_Dashboard/flight_app/images/dashboard_delay_tab.png)


**Forecast tab:**
![Image of forecast tab](https://github.com/mike-amodeo/UCB_Portfolio/blob/master/Air_Travel_Dashboard/flight_app/images/dashboard_forecast_tab.png)
