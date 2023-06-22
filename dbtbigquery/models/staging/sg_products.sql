with source as (

    select * from {{ source('northwind', 'products') }}
)
select 
    *,
    current_timestamp() as ingestion_timestamp
from source
where supplier_ids not like '%;%' 
