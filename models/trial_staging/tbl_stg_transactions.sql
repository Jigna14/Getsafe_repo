{{ config(materialized='table',
tags = ['staging', 'finance']
)}}

select
{{ dbt_utils.generate_surrogate_key(['customer_id'])}} as customer_id_hk,
customer_id,
signup_date,
city,
country,
employment_type,
annual_income,
created_at,
{{ macro_example('annual_income') }} as income_100
from {{ source('getsafe', 'customers') }}

