select *
from {{ source('stage', 'manufacturing_unit') }}
