select *
from {{ source('stage', 'item') }}
