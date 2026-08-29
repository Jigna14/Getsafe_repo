{{ config(materialized='table',
tags = ['staging', 'finance']
)}}

select
customer_id,
signup_date,
city,
country,
employment_type,
annual_income,
created_at
from {{ source('getsafe', 'customers') }}

