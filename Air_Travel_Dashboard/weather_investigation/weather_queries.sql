-- 25 busiest US airports
-- 'ATL', 'ORD', 'DFW', 'DEN', 'LAX', 'PHX', 'IAH', 'LAS', 'DTW', 'MSP', 'EWR', 'SLC',
-- 'SFO', 'MCO', 'BOS', 'CLT', 'JFK', 'LGA', 'BWI', 'SEA', 'PHL', 'SAN', 'MDW', 'DCA', 'TPA'

-- Find number of days of data
set years = select count(distinct date_yyyymmdd)/365 from precip;

-- format dates to match airline data format
drop table if exists precip_format;
create table precip_format as
    select *,
    substring(date_yyyymmdd, 0, 4) as year,
    substring(date_yyyymmdd, 5, 2) as month,
    substring(date_yyyymmdd, 7, 2) as day,
    concat(substring(date_yyyymmdd, 0, 4), '-', substring(date_yyyymmdd, 5, 2), '-',substring(date_yyyymmdd, 7, 2)) as date_rev
    from precip;

-- Find average days of precipitation for all airports
-- Use 10.25 as approximation for number of years given run at end of April 2017
drop table if exists precip_days_ann;
create table precip_days_ann as
SELECT AIRPORT, cast((count(distinct date_yyyymmdd)) / 10.25 as int) as ann_days
from precip
group by AIRPORT
order by ann_days desc;

--  Find total depth of rain at each of 25 busiest US airports per month
drop table if exists most_rain;
create table most_rain as
SELECT AIRPORT, month, year, sum(magnitude) as total_rain
from precip_format
where weather_type = 'PRCP'
and airport in ('ATL', 'ORD', 'DFW', 'DEN', 'LAX', 'PHX', 'IAH', 'LAS', 'DTW', 'MSP', 'EWR', 'SLC',
    'SFO', 'MCO', 'BOS', 'CLT', 'JFK', 'LGA', 'BWI', 'SEA', 'PHL', 'SAN', 'MDW', 'DCA', 'TPA')
group by AIRPORT, month, year
order by total_rain desc;

-- Find average depth of rain per month at each of 25 busiest US airports
drop table if exists monthly_rain;
create table monthly_rain as
SELECT AIRPORT, month, cast(sum(magnitude) / count(distinct year) as decimal (5,1)) as month_rain, count(distinct year) as years
from precip_format
where weather_type = 'PRCP'
and airport in ('ATL', 'ORD', 'DFW', 'DEN', 'LAX', 'PHX', 'IAH', 'LAS', 'DTW', 'MSP', 'EWR', 'SLC',
    'SFO', 'MCO', 'BOS', 'CLT', 'JFK', 'LGA', 'BWI', 'SEA', 'PHL', 'SAN', 'MDW', 'DCA', 'TPA')
group by AIRPORT, month
order by month_rain desc;


-- Find depth of snow at each of 25 busiest US airports
drop table if exists most_snow;
create table most_snow as
SELECT AIRPORT, sum(magnitude) as total_snow
from precip_format
where weather_type = 'SNOW'
and airport in ('ATL', 'ORD', 'DFW', 'DEN', 'LAX', 'PHX', 'IAH', 'LAS', 'DTW', 'MSP', 'EWR', 'SLC',
    'SFO', 'MCO', 'BOS', 'CLT', 'JFK', 'LGA', 'BWI', 'SEA', 'PHL', 'SAN', 'MDW', 'DCA', 'TPA')
group by AIRPORT
order by total_snow desc;

-- Find average depth of snow per month at each of 25 busiest US airports
drop table if exists monthly_snow;
create table monthly_snow as
SELECT AIRPORT, month, cast(sum(magnitude) / count(distinct year) as decimal (5,1)) as month_snow, count(distinct year) as years
from precip_format
where weather_type = 'SNOW'
and airport in ('ATL', 'ORD', 'DFW', 'DEN', 'LAX', 'PHX', 'IAH', 'LAS', 'DTW', 'MSP', 'EWR', 'SLC',
    'SFO', 'MCO', 'BOS', 'CLT', 'JFK', 'LGA', 'BWI', 'SEA', 'PHL', 'SAN', 'MDW', 'DCA', 'TPA')
group by AIRPORT, month
order by month_snow desc;
