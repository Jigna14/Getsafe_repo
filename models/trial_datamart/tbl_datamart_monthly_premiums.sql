{{ config(materialized='table') }}



select
    party,
    premium_month as month,
    round(sum(premium_amount), 2) as premium
from {{ ref('tbl_fct_premium_transactions') }}
group by 1,2
