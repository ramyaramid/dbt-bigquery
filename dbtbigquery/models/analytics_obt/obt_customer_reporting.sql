select 

c.customer_id as customer_id,
c.company as company_name,
c.last_name as customer_last_name,
c.first_name as customer_first_name,
c.email_address as customer_email_address,
c.job_title as customer_job_title,
c.business_phone as customer_business_phone ,
c.home_phone as customer_home_phone,
c.mobile_phone as customer_mobile_phone,
c.fax_number as customer_fax_number ,
c.address as  customer_address,
c.city as customer_city ,
c.state_province as customer_state_province,
c.zip_postal_code as customer_zip_postal_code,
c.country_region as customer_country_region,
c.web_page as customer_web_page,
c.notes as customer_notes,
c.attachments as customer_attachments,

e.employee_id as employee_id,
e.company as employee_company,
e.last_name as employee_last_name,
e.first_name as employee_first_name,
e.email_address as employee_email_address,
e.job_title as employee_job_title,
e.business_phone as employee_business_phone,
e.home_phone as employee_home_phone,
e.mobile_phone as employee_mobile_phone,
e.fax_number as employee_fax_number,
e.address as employee_address,
e.city as employee_city,
e.state_province as employee_state_province,
e.zip_postal_code as employee_zip_postal_code,
e.country_region as employee_country_region,
e.web_page as employee_web_page,
e.notes as employee_notes,
e.attachments as employee_attachments,

p.product_id as product_id,
p.product_code as product_code,
p.product_name as product_name,
p.description as product_description,
p.supplier_company as  supplier_company,
p.standard_cost as product_standard_cost,
p.list_price as product_list_price,
p.reorder_level as product_reorder_level,
p.target_level as product_target_level,
p.quantity_per_unit as product_quantity_per_unit,
p.discontinued  as product_discontinued,
p.minimum_reorder_quantity as product_minimum_reorder_quantity,
p.category as product_category,
p.attachments as product_attachments,
fp.purchase_order_id as purchase_order_id,

fp.quantity ,
fp.unit_cost ,
fp.date_received ,
fp.posted_to_inventory,
fp.inventory_id,
fp.supplier_id,
fp.created_by,
fp.submitted_date,
fp.creation_date,
fp.status_id,
fp.expected_date,
fp.shipping_fee,
fp.taxes,
fp.payment_date,
fp.payment_amount,
fp.payment_method,
fp.notes,
fp.approved_by,
fp.approved_date,
fp.submitted_by,
current_timestamp() as insertion_timestamp



from 
{{ref('fact_purchase_order')}} as fp
left join 
{{ref('dim_product')}} p on fp.product_id=p.product_id
left join
{{ref('dim_customer')}} c on fp.customer_id=c.customer_id
left join
{{ref('dim_employee')}} e on fp.employee_id=e.employee_id
