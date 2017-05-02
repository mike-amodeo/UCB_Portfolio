-- Test joins. Show aiport days with delay performance that day
drop table if exists delays_weather;
create table delays_weather as
    select airport, date_rev, magnitude, weather_type,
    count(flightnum) as total_flights,
    count(case when depdelay > 0 then 1 else null end) as delayed_flights,
    sum(depdelay) as total_delays,
    count(case when weatherdelay > 0 then 1 else null end > 0) as delayed_weather,
    sum(weatherdelay) as total_weather_delay,
    cast(count(case when depdelay > 0 then 1 else null end) / count(flightnum) as decimal (3,2)) as percent_delayed
    from precip_format, flights_2007_2016
    where precip_format.airport = flights_2007_2016.origin
    and precip_format.date_rev = flights_2007_2016.flightdate
    and airport in ('ATL', 'ORD', 'DFW', 'DEN', 'LAX', 'PHX', 'IAH', 'LAS', 'DTW', 'MSP', 'EWR', 'SLC',
        'SFO', 'MCO', 'BOS', 'CLT', 'JFK', 'LGA', 'BWI', 'SEA', 'PHL', 'SAN', 'MDW', 'DCA', 'TPA')
    group by airport, date_rev, magnitude, weather_type
    order by percent_delayed desc;

-- Table of days at each airport with flight performance
drop table if exists airport_days;
create table airport_days as
    select origin, flightdate, month,
    count(flightnum) as total_flights,
    count(case when depdelay > 0 then 1 else null end) as delayed_flights,
    count(case when weatherdelay > 0 then 1 else null end) as delayed_weather,
    cast(count(case when depdelay > 0 then 1 else null end) / count(flightnum) as decimal (3,2)) as percent_delayed,
    cast(count(case when weatherdelay > 0 then 1 else null end) / count(flightnum) as decimal (3,2)) as percent_weather
    from flights_2007_2016
    group by origin, flightdate, month;

-- Combine airport days with rainfall
drop table if exists airport_precip;
create table airport_precip as
    select origin, flightdate, airport_days.month, total_flights, delayed_flights, delayed_weather, percent_delayed, percent_weather,
    case when magnitude > 0 then magnitude else 0 end as precip_depth,
    coalesce(case when (magnitude = 0 or magnitude is null) then 0 else null end,
    case when (magnitude >0 and magnitude <=63) then 0.25 else null end,
    case when (magnitude >63 and magnitude <=127) then 0.5 else null end,
    case when (magnitude >127 and magnitude <=254) then 1 else null end,
    case when (magnitude >254 and magnitude <=381) then 1.5 else null end,
    case when (magnitude >381 and magnitude <=508) then 2 else null end,
    case when (magnitude >508 and magnitude <=762) then 3 else null end,
    case when magnitude >762 then 4 else 0 end) as precip_bin
    from airport_days
    left join (
        select *
        from precip_format
        where weather_type = 'PRCP'
    ) O
    on O.airport = airport_days.origin
    and O.date_rev = airport_days.flightdate;

-- combine airport days with snowfall
drop table if exists airport_snow;
create table airport_snow as
    select origin, flightdate, airport_days.month, total_flights, delayed_flights, delayed_weather, percent_delayed, percent_weather,
    case when magnitude > 0 then magnitude else 0 end as snow_depth,
    coalesce(case when (magnitude = 0 or magnitude is null) then 0 else null end,
    case when (magnitude >0 and magnitude <=63) then 0.25 else null end,
    case when (magnitude >63 and magnitude <=127) then 0.5 else null end,
    case when (magnitude >127 and magnitude <=254) then 1 else null end,
    case when (magnitude >254 and magnitude <=508) then 2 else null end,
    case when (magnitude >508 and magnitude <=1016) then 4 else null end,
    case when (magnitude >1016 and magnitude <=1524) then 6 else null end,
    case when magnitude >1524 then 4 else 0 end) as snow_bin
    from airport_days
    left join (
        select *
        from precip_format
        where weather_type = 'SNOW'
    ) O
    on O.airport = airport_days.origin
    and O.date_rev = airport_days.flightdate;

-- likelihood of weather delay per airport per month
drop table if exists likelihood_monthly;
create table likelihood_monthly as
    select origin, airport_days.month, sum(total_flights), sum(delayed_weather),
    cast(sum(delayed_weather) / sum(total_flights) as decimal (4,3)) as likelihood
    from airport_days
    left join precip_format
    on precip_format.airport = airport_days.origin
    and precip_format.date_rev = airport_days.flightdate
    where airport in ('ATL', 'ORD', 'DFW', 'DEN', 'LAX', 'PHX', 'IAH', 'LAS', 'DTW', 'MSP', 'EWR', 'SLC',
        'SFO', 'MCO', 'BOS', 'CLT', 'JFK', 'LGA', 'BWI', 'SEA', 'PHL', 'SAN', 'MDW', 'DCA', 'TPA')
    group by origin, airport_days.month;

