{{ config(
    materialized='table'
) }}

with sensor_health as (

    select
        device_id,
        timestamp,

        lag(timestamp) over (
            partition by device_id
            order by timestamp
        ) as previous_timestamp

    from {{ ref('tbl_stg_sensor_readings') }}

),

with_gap_duration as (

    select
        device_id,
        timestamp,
        previous_timestamp,

        timestamp_diff(
            timestamp,
            previous_timestamp,
            minute
        ) as minutes_since_previous_reading

    from sensor_health

)

select
    device_id,
    timestamp,
    previous_timestamp,
    minutes_since_previous_reading,

    case
        when minutes_since_previous_reading > 15
            then true
        else false
    end as has_reporting_gap

from with_gap_duration