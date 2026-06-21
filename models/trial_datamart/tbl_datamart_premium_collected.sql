{{ config(materialized='table') }}

select
    calendar_date,
    product_group,
    user_id,
    premium,
    premium * 12.0 / 365.25
        as daily_earned_premium
from {{ ref('tbl_int_daily_contract_activity') }}
