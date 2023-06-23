with final as
(
select 
fp.inventory_id as unique_inventory_id, 
fp.transaction_type  as transaction_type, 
fp.transaction_created_date   as  transaction_created_date , 
fp.transaction_modified_date  as transaction_modified_date, 
fp.product_id  as ipd, 
fp.quantity   as quantity , 
fp.purchase_order_id  as purchase_order_id, 
fp.customer_order_id  as customer_order_id, 
fp.comments  as comments, 
p.product_id as product_id, 
p.product_code as  product_code, 
p.product_name as product_name, 
p.description as  product_description, 
p.supplier_company as  supplier_company, 
p.standard_cost as  product_standard_cost, 
p.list_price as  product_list_price, 
p.reorder_level as  product_reorder_level, 
p.target_level as  product_target_level, 
p.quantity_per_unit as  product_quantity_per_unit, 
p.discontinued as  product_discontinued, 
p.minimum_reorder_quantity as  product_minimum_reorder_quantity, 
p.category as  product_category, 
p.attachments as  product_attachments, 

 from

{{ref('fact_inventory')}} fp
 

left join 
{{ref('dim_product')}} p on fp.product_id=p.product_id

)
select * from final
