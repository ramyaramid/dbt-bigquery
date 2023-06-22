
with final as
(
select
id as inventory_id,
transaction_type,
transaction_created_date,
transaction_modified_date,
product_id,
quantity,
purchase_order_id,
customer_order_id,
comments,
current_timestamp() as  insertion_timestamp
from {{ref("sg_inventory_transactions")}}
),
cte as
(
select *, row_number() over(partition by inventory_id ) as rownumber
from final
)
select *

except (rownumber)
from cte
where rownumber=1
