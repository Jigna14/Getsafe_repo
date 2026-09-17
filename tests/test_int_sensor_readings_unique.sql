select
    device_id,
    timestamp,
    count(*) as record_count

from {{ ref('tbl_int_sensor_readings') }}

group by
    device_id,
    timestamp

having count(*) > 1