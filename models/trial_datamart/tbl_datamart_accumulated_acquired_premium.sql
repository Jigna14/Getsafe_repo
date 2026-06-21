{{ config(materialized='table') }}

with acquisitions as (
    select
        acquisition_date,
        product_group,
        premium
    from {{ ref('tbl_stg_contracts') }}
)
select *
from acquisitions
