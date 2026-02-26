select *
from {{ source('stage', 'allowance_days') }}
