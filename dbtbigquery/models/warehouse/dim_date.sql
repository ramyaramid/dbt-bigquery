with final as
(
select * from

unnest(generate_date_array('2014-01-01','2050-01-01', interval 1 day) )  as dates
)

select 
format_date('%F',dates) as id,
dates as full_date,
EXTRACT(year from dates) as year,
EXTRACT(month from dates) as month,
EXTRACT(day from dates) as year_day,
format_date('%B',dates) as month_name,
EXTRACT(week from dates) as year_week,
EXTRACT(year from dates) as fiscal_year,
format_date('%Q',dates) as fiscal_qtr,
format_date('%w',dates) as week_day,
format_date('%A',dates) as day_name,
(case when (format_date('%A',dates)='Saturday' or format_date('%A',dates)='Sunday'  ) then 'Weekend' else 'Weekday' end) as day_if_weekend

from final
