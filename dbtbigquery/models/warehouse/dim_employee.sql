with final as(
select
id as employee_id,
company,
last_name,
first_name,
email_address,
job_title,
business_phone,
home_phone,
mobile_phone,
fax_number,
address,
city,
state_province,
zip_postal_code,
country_region,
web_page,
notes,
attachments,
current_timestamp() as inserstion_timestamp
from {{ ref('sg_employees')}}
),
cte as
(
select *, row_number() over(partition by employee_id ) as rownumber
from final
)
select *

except (rownumber)
from cte
where rownumber=1