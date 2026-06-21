{{ config(materialized='table') }}

with dates as (

    {{
        dbt_utils.date_spine(
            datepart="day",
            start_date="'2018-01-01'",
            end_date="dateadd(year,5,current_date)"
        )
    }}

)

select cast(date_day as date) as calendar_date
from dates