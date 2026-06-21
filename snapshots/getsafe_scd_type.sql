{% snapshot contracts_snapshot %}
{{
    config(
        target_schema='snapshots',
        unique_key='user_id',
        strategy='check',
        check_cols=['started_at','churned_at','premium']
    )
}}
select *
from {{ source('raw','contracts') }}
{% endsnapshot %}
