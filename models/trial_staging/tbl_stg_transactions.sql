{{ config(materialized='table',
   cluster_by= ['created_at'],
   tags = ['finance', 'staging']
) }}



select
{{ dbt_utils.generate_surrogate_key(['customer_id'])}} as customer_id_hk,
customer_id,
signup_date,
city,
country,
employment_type,
annual_income,
created_at,
{{ macro_example('annual_income') }} as income_100,
{{ macro_revenue('annual_income',15)}} as revenue_15
from {{ source('getsafe', 'customers') }}

