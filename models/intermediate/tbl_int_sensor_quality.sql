{{ config(
    materialized='table'
) }}

select
    device_id,
    timestamp,
    substrate_label,

    soil_moisture_vwc,
    soil_temp_c,
    ec_us_cm,
    light_par,
    air_humidity_pct,

    case
        when soil_moisture_vwc < 0
            then null
        else soil_moisture_vwc
    end as soil_moisture_clean,

    case
        when device_id = 'SENS-07'
             and soil_temp_c > 50
            then null
        else soil_temp_c
    end as soil_temp_clean,

    case
        when device_id = 'SENS-08'
             and air_humidity_pct > 100
            then null
        else air_humidity_pct
    end as air_humidity_clean,

    soil_moisture_vwc < 0
        as is_negative_moisture,

    (
        device_id = 'SENS-07'
        and soil_temp_c > 50
    ) as is_suspect_temperature,

    (
        device_id = 'SENS-08'
        and air_humidity_pct > 100
    ) as is_suspect_humidity,

    (
        device_id = 'SENS-04'
        and soil_moisture_vwc > 100
    ) as is_moisture_review

from {{ ref('tbl_stg_sensor_readings') }}