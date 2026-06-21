
{{
    config(
        materialized='table')
}}

select
    transaction_id,
    created_at,
    date_trunc('month', created_at) as premium_month,
    party,
    premium_amount,
    status
from {{ ref('tbl_stg_transactions') }}
where status = 'processed'

