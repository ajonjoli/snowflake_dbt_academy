-- singular test: net_revenue should never be negative on completed orders
-- a completed order with negative net means payments are miscalculated
select
    order_id,
    net_revenue
from {{ ref('fct_orders') }}
where order_status = 'completed'
    and net_revenue < 0
