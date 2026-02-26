select *
from {{ source('stage', 'calendar') }}
