{{ config(
    materialized='view'
) }}

with source_data as (

    select
        device_id,
        timestamp as timestamp_raw,
        substrate_label,
        soil_moisture_vwc,
        soil_temp_c,
        ec_us_cm,
        light_par,
        air_humidity_pct,

   cast(     case
            when regexp_contains(timestamp, r'^\d{4}-\d{2}-\d{2}')
                then parse_timestamp('%Y-%m-%d %H:%M:%S', timestamp)

            when regexp_contains(timestamp, r'^\d{2}/\d{2}/\d{4}')
                then parse_timestamp('%d/%m/%Y %H:%M', timestamp)

            else cast(null as timestamp)
        end as timestamp) as timestamp

    from {{ source('fyta_raw', 'fyta_sensor_sample') }}

),

deduplicated as (

    select
        *,
        row_number() over (
            partition by device_id, timestamp
            order by timestamp_raw
        ) as row_num

    from source_data

)

select
    device_id,
    timestamp_raw,
    timestamp,
    substrate_label,
    soil_moisture_vwc,
    soil_temp_c,
    ec_us_cm,
    light_par,
    air_humidity_pct

from deduplicated

where row_num = 1