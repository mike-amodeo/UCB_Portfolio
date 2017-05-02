-- Create table of likelihood of weather related delay per airport per month

drop table if exists likelihood_monthly_pivot;
create table likelihood_monthly_pivot as
    select origin,
    max(case when month = 1 then likelihood else 0 end) as Jan,
    max(case when month = 2 then likelihood else 0 end) as Feb,
    max(case when month = 3 then likelihood else 0 end) as Mar,
    max(case when month = 4 then likelihood else 0 end) as Apr,
    max(case when month = 5 then likelihood else 0 end) as May,
    max(case when month = 6 then likelihood else 0 end) as Jun,
    max(case when month = 7 then likelihood else 0 end) as Jul,
    max(case when month = 8 then likelihood else 0 end) as Aug,
    max(case when month = 9 then likelihood else 0 end) as Sep,
    max(case when month = 10 then likelihood else 0 end) as Oct,
    max(case when month = 11 then likelihood else 0 end) as Nov,
    max(case when month = 12 then likelihood else 0 end) as Dec
    from likelihood_monthly
    group by origin;

