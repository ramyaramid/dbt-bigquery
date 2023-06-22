{{config(
    partition_by={
        "field":"order_date",
        "data_type":"date"
    }
)}}


with final as
(
select 
od.order_id ,
od.product_id,
o.customer_id,
o.employee_id,
o.shipper_id,
od.quantity,
od.unit_price,
od.discount,
od.status_id,
od.date_allocated,
od.purchase_order_id,
od.inventory_id,
o.order_date,
o.shipped_date,
o.paid_date,
current_timestamp() as insertion_timestamp
from {{ref('stg_orders')}} o left join {{ref('sg_order_details')}} od
on o.id=od.order_id
where od.order_id is not null


),
cte as
(
select *, row_number() over(partition by order_id,product_id,customer_id,employee_id,shipper_id ,order_date,purchase_order_id ) as rownumber
from final
)
select *

except (rownumber)
from cte
where rownumber=1
