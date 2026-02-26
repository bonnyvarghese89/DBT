select *
from {{ source('stage', 'goods_received') }}
