with final as
(
select

c.id as  customer_id,
e.id as employee_id,
pd.purchase_order_id,
pd.product_id,
pd.quantity,
pd.unit_cost,
pd.date_received,
pd.posted_to_inventory,
pd.inventory_id,
po.supplier_id,
po.created_by,
po.submitted_date,
date(po.creation_date) as creation_date,
po.status_id,
po.expected_date,
po.shipping_fee,
po.taxes,
po.payment_date,
po.payment_amount,
po.payment_method,
po.notes,
po.approved_by,
po.approved_date,
po.submitted_by,
current_timestamp() as insertion_timestamp

from 
 {{ref('sg_purchase_order_details')}} pd

left join 

 {{ref('sg_purchase_orders')}} po  on po.id=pd.purchase_order_id
left join 
{{ref('sg_products')}} p on p.id=pd.product_id
left join
{{ref('sg_order_details')}} od on 
od.product_id=p.id
left join 
{{ref('stg_orders')}} o on
o.id=od.order_id
left join 
{{ref('stg_customer')}} c  on
o.customer_id=c.id
left join 
{{ref('sg_employees')}} e on
e.id=po.created_by
where o.customer_id is not null



),
cte as
(
select *, row_number() over(partition by customer_id,employee_id,purchase_order_id,product_id,inventory_id,supplier_id,creation_date) as rownumber
from final
)
select *

except (rownumber)
from cte
where rownumber=1
