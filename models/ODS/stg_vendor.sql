select *
from {{ source('stage', 'vendor') }}
