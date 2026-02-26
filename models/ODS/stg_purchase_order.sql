select *
from {{ source('stage', 'purchase_order') }}
