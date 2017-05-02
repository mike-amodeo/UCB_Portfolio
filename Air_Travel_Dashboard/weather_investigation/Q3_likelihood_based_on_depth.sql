-- Likelihood of a delay based on varied rainfall depth

drop table if exists delay_depth;
create table delay_depth as
    select O.origin,
    max(case when precip_bin = 0 then likelihood else 0 end) as inch_0,
    max(case when precip_bin = 0.25 then likelihood else 0 end) as inch_0_25,
    max(case when precip_bin = 0.5 then likelihood else 0 end) as inch_0_5,
    max(case when precip_bin = 1 then likelihood else 0 end) as inch_1,
    max(case when precip_bin = 1.5 then likelihood else 0 end) as inch_1_5,
    max(case when precip_bin = 2 then likelihood else 0 end) as inch_2,
    max(case when precip_bin = 3 then likelihood else 0 end) as inch_3,
    max(case when precip_bin = 4 then likelihood else 0 end) as inch_4
    from (
        select origin, precip_bin,
        cast(sum(delayed_weather) / sum(total_flights) as decimal (4,3)) as likelihood
        from airport_precip
        where origin in ('ATL', 'ORD', 'DFW', 'DEN', 'LAX', 'PHX', 'IAH', 'LAS', 'DTW', 'MSP', 'EWR', 'SLC',
            'SFO', 'MCO', 'BOS', 'CLT', 'JFK', 'LGA', 'BWI', 'SEA', 'PHL', 'SAN', 'MDW', 'DCA', 'TPA')
        group by origin, precip_bin
    ) O
    group by O.origin;
