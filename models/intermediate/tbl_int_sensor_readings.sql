{{ config(
    materialized='table'
) }}

select
    q.device_id,
    q.timestamp,
    q.substrate_label,

    -- Raw measurements
    q.soil_moisture_vwc,
    q.soil_temp_c,
    q.ec_us_cm,
    q.light_par,
    q.air_humidity_pct,

    -- Cleaned measurements
    q.soil_moisture_clean,
    q.soil_temp_clean,
    q.air_humidity_clean,

    -- Quality flags
    q.is_negative_moisture,
    q.is_suspect_temperature,
    q.is_suspect_humidity,
    q.is_moisture_review,

    -- Device health
    h.minutes_since_previous_reading,
    h.has_reporting_gap

from {{ ref('tbl_int_sensor_quality') }} q

left join {{ ref('tbl_int_sensor_health') }} h
    on q.device_id = h.device_id
    and q.timestamp = h.timestamp