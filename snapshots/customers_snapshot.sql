{% snapshot customers_snapshot %}

{{ config(
    target_schema = 'snapshots',
    unique_key = 'customer_id',
    strategy = 'timestamp',
    updated_at = 'created_at'
) }}

    select 
        customer_id,
        signup_date,
        city,
        country,
        employment_type,
        annual_income,
        created_at
    from {{ref('tbl_stg_transactions')}}

 

{% endsnapshot %}