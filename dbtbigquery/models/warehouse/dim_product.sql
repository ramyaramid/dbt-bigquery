with final as
(
select
p.id as  product_id,
p.product_code,
p.product_name,
p.description,
s.company as supplier_company,
p.standard_cost,
p.list_price,
p.reorder_level,
p.target_level,
p.quantity_per_unit,
p.discontinued,
p.minimum_reorder_quantity,
p.category,
p.attachments,
current_timestamp() as insertion_timestamp
from {{ref("sg_products")}} p  left join  {{ref("sg_suppliers")}} s
on s.id = cast(p.supplier_ids as int64)

),
cte as
(
select *, row_number() over(partition by product_id ) as rownumber
from final
)
select *

except (rownumber)
from cte
where rownumber=1
