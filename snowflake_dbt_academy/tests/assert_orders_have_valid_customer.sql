-- singular test: every order in fct_orders should link to a valid customer in dim_customers
select
    f.order_id,
    f.customer_id
from {{ ref('fact_orders') }} f
left join {{ ref('dim_customers') }} d
    on f.customer_id = d.customer_id
where d.customer_id is null