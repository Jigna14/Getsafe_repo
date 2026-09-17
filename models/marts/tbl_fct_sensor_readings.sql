{{ config(
    materialized='incremental',
    unique_key=['device_id', 'timestamp'],
    incremental_strategy='merge'
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

    soil_moisture_clean,
    soil_temp_clean,
    air_humidity_clean,

    is_negative_moisture,
    is_suspect_temperature,
    is_suspect_humidity,
    is_moisture_review,

    minutes_since_previous_reading,
    has_reporting_gap

from {{ ref('tbl_int_sensor_readings') }}

{% if is_incremental() %}

where timestamp >= (
    select
        timestamp_sub(
            max(timestamp),
            interval 1 day
        )
    from {{ this }}
)

{% endif %}