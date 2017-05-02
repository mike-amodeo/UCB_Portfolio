--Creating weather_data schema in Hive

-- 2007
DROP TABLE IF EXISTS weather_2007;
CREATE EXTERNAL TABLE weather_2007 (
station_id string,
date_yyyymmdd string,
weather_type string,
magnitude string,
col1 string,
col2 string,
col3 string,
col4 string)
ROW FORMAT SERDE
  'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES(
"separatorChar"=',',
"quoteChar"='"',
"escapeChar"='\\'
)
STORED AS TEXTFILE
LOCATION
'/user/w205/final_project/weather/2007';

-- 2008
DROP TABLE IF EXISTS weather_2008;
CREATE EXTERNAL TABLE weather_2008 (
station_id string,
date_yyyymmdd string,
weather_type string,
magnitude string,
col1 string,
col2 string,
col3 string,
col4 string)
ROW FORMAT SERDE
  'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES(
"separatorChar"=',',
"quoteChar"='"',
"escapeChar"='\\'
)
STORED AS TEXTFILE
LOCATION
'/user/w205/final_project/weather/2008';

-- 2009
DROP TABLE IF EXISTS weather_2009;
CREATE EXTERNAL TABLE weather_2009 (
station_id string,
date_yyyymmdd string,
weather_type string,
magnitude string,
col1 string,
col2 string,
col3 string,
col4 string)
ROW FORMAT SERDE
  'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES(
"separatorChar"=',',
"quoteChar"='"',
"escapeChar"='\\'
)
STORED AS TEXTFILE
LOCATION
'/user/w205/final_project/weather/2009';

-- 2010
DROP TABLE IF EXISTS weather_2010;
CREATE EXTERNAL TABLE weather_2010 (
station_id string,
date_yyyymmdd string,
weather_type string,
magnitude string,
col1 string,
col2 string,
col3 string,
col4 string)
ROW FORMAT SERDE
  'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES(
"separatorChar"=',',
"quoteChar"='"',
"escapeChar"='\\'
)
STORED AS TEXTFILE
LOCATION
'/user/w205/final_project/weather/2010';

-- 2011
DROP TABLE IF EXISTS weather_2011;
CREATE EXTERNAL TABLE weather_2011 (
station_id string,
date_yyyymmdd string,
weather_type string,
magnitude string,
col1 string,
col2 string,
col3 string,
col4 string)
ROW FORMAT SERDE
  'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES(
"separatorChar"=',',
"quoteChar"='"',
"escapeChar"='\\'
)
STORED AS TEXTFILE
LOCATION
'/user/w205/final_project/weather/2011';

-- 2012
DROP TABLE IF EXISTS weather_2012;
CREATE EXTERNAL TABLE weather_2012 (
station_id string,
date_yyyymmdd string,
weather_type string,
magnitude string,
col1 string,
col2 string,
col3 string,
col4 string)
ROW FORMAT SERDE
  'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES(
"separatorChar"=',',
"quoteChar"='"',
"escapeChar"='\\'
)
STORED AS TEXTFILE
LOCATION
'/user/w205/final_project/weather/2012';

-- 2013
DROP TABLE IF EXISTS weather_2013;
CREATE EXTERNAL TABLE weather_2013 (
station_id string,
date_yyyymmdd string,
weather_type string,
magnitude string,
col1 string,
col2 string,
col3 string,
col4 string)
ROW FORMAT SERDE
  'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES(
"separatorChar"=',',
"quoteChar"='"',
"escapeChar"='\\'
)
STORED AS TEXTFILE
LOCATION
'/user/w205/final_project/weather/2013';

-- 2014
DROP TABLE IF EXISTS weather_2014;
CREATE EXTERNAL TABLE weather_2014 (
station_id string,
date_yyyymmdd string,
weather_type string,
magnitude string,
col1 string,
col2 string,
col3 string,
col4 string)
ROW FORMAT SERDE
  'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES(
"separatorChar"=',',
"quoteChar"='"',
"escapeChar"='\\'
)
STORED AS TEXTFILE
LOCATION
'/user/w205/final_project/weather/2014';

-- 2015
DROP TABLE IF EXISTS weather_2015;
CREATE EXTERNAL TABLE weather_2015 (
station_id string,
date_yyyymmdd string,
weather_type string,
magnitude string,
col1 string,
col2 string,
col3 string,
col4 string)
ROW FORMAT SERDE
  'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES(
"separatorChar"=',',
"quoteChar"='"',
"escapeChar"='\\'
)
STORED AS TEXTFILE
LOCATION
'/user/w205/final_project/weather/2015';

-- 2016
DROP TABLE IF EXISTS weather_2016;
CREATE EXTERNAL TABLE weather_2016 (
station_id string,
date_yyyymmdd string,
weather_type string,
magnitude string,
col1 string,
col2 string,
col3 string,
col4 string)
ROW FORMAT SERDE
  'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES(
"separatorChar"=',',
"quoteChar"='"',
"escapeChar"='\\'
)
STORED AS TEXTFILE
LOCATION
'/user/w205/final_project/weather/2016';

-- 2017
DROP TABLE IF EXISTS weather_2017;
CREATE EXTERNAL TABLE weather_2017 (
station_id string,
date_yyyymmdd string,
weather_type string,
magnitude string,
col1 string,
col2 string,
col3 string,
col4 string)
ROW FORMAT SERDE
  'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES(
"separatorChar"=',',
"quoteChar"='"',
"escapeChar"='\\'
)
STORED AS TEXTFILE
LOCATION
'/user/w205/final_project/weather/2017';

-- Creating for airports and weather stations table
DROP TABLE IF EXISTS airports_stations;
CREATE EXTERNAL TABLE airports_stations (
    index_no string,
    AIRPORT_ID string,
    AIRPORT string,
    station_id string,
    distance string)
ROW FORMAT SERDE
    'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES(
"separatorChar"=',',
"quoteChar"='"',
"escapeChar"='\\'
)
STORED AS TEXTFILE
LOCATION
'/user/w205/final_project/weather/airport_stations';


