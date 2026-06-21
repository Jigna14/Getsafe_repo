
{{ config(materialized='table') }}
select
    transaction_id,
    cast(created_at as timestamp) as created_at,
    cast(premium_amount as numeric(18,2)) as premium_amount,
    premium_currency,
    lower(charged_party) as party,
    lower(status) as status
from {{ source('getsafe', 'DATA_FOR_ANALYTICS_CASE_STUDY') }}
