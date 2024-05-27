import sys
import json

fields_v_slice = sys.argv[1]
hs_out = sys.argv[2]

with open(fields_v_slice, 'r') as f:
    fields_v_slice_dict = json.loads(f.read())

populatedFields = []
for index, (field, slice) in enumerate(fields_v_slice_dict.items()):
    field_bitlen = slice[1] - slice[0] + 1
    if index == 0:
        populatedFields += [f"  = Populated_{field:<7} (Unsigned {field_bitlen})"]
    else:
        populatedFields += [f"  | Populated_{field:<7} (Unsigned {field_bitlen})"]


unpopulatedFields = []
for index, (field, slice) in enumerate(fields_v_slice_dict.items()):
    field_bitlen = slice[1] - slice[0] + 1
    if index == 0:
        unpopulatedFields += [f"  = Unpopulated_{field:<7}"]
    else:
        unpopulatedFields += [f"  | Unpopulated_{field:<7}"]

generated_hs = \
f'''{{-# LANGUAGE DataKinds #-}}
{{-# LANGUAGE NumericUnderscores #-}}

module Decode.Fields(UnpopulatedField(..), PopulatedField(..)) where
import Clash.Prelude

data UnpopulatedField
{'\n'.join(unpopulatedFields)}
  deriving (Generic, Show, Eq, NFDataX)

data PopulatedField
{'\n'.join(populatedFields)}
  deriving (Generic, Show, Eq, NFDataX)
'''

with open(hs_out, 'w') as f:
    f.write(generated_hs)