select
    coalesce(f.party, a.party) as party,
    coalesce(f.month::date, a.month) as month,

    f.premium as finance_premium,
    a.premium as accounting_premium,

    coalesce(f.premium,0) - coalesce(a.premium,0) as variance,

    case
        when abs(coalesce(f.premium,0) - coalesce(a.premium,0)) < 0.01
        then 'MATCH'
        else 'MISMATCH'
    end as status

from {{ ref('tbl_datamart_monthly_premiums') }} f
full outer join {{ source('getsafe', 'GETSAFE_ACCOUNT_CSV') }} a
    on f.party = a.party
   and date_trunc('month', f.month)::date =
       date_trunc('month', a.month)