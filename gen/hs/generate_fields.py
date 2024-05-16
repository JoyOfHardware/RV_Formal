import sys
import json

fields_v_slice = sys.argv[1]
hs_out = sys.argv[2]

with open(fields_v_slice, 'r') as f:
    fields_v_slice_dict = json.loads(f.read())

fields = []

for index, (field, slice) in enumerate(fields_v_slice_dict.items()):
    field_bitlen = slice[1] - slice[0]
    if index == 0:
        fields += [f"  = {field} (Unsigned {field_bitlen})"]
    else:
        fields += [f"  | {field} (Unsigned {field_bitlen})"]

generated_hs = \
f'''{{-# LANGUAGE DataKinds #-}}
{{-# LANGUAGE NumericUnderscores #-}}

module Fields(Field(..)) where
import Clash.Prelude

data Field
{'\n'.join(fields)}
  deriving (Generic, Show, Eq, NFDataX)
'''

with open(hs_out, 'w') as f:
    f.write(generated_hs)