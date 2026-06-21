{{ config(materialized='view') }}

select
    cast(user_id as string) as user_id,
    cast(acquisition_date as date) as acquisition_date,
    cast(started_at as date) as started_at,
    cast(churned_at as date) as churned_at,
    cast(premium as numeric) as premium,
    lower(product_group) as product_group
from {{ source('raw','contracts') }}
