import sys
import json

fields_v_slice = sys.argv[1]
hs_out = sys.argv[2]

with open(fields_v_slice, 'r') as f:
    fields_v_slice_dict = json.loads(f.read())

getFieldFuncs = []
for index, (field, slice) in enumerate(fields_v_slice_dict.items()):
    field_bitlen = slice[1] - slice[0] + 1
    getFieldFuncs.append(
f"""
"""
    )

    if index == 0:
        populatedFields += [f"  = Populated_{field:<7} (Unsigned {field_bitlen})"]
        # populatedfields += [f"  = {field}"]
    else:
        populatedFields += [f"  | Populated_{field:<7} (Unsigned {field_bitlen})"]
        # populatedfields += [f"  | {field}"]


unpopulatedFields = []
for index, (field, slice) in enumerate(fields_v_slice_dict.items()):
    field_bitlen = slice[1] - slice[0] + 1
    if index == 0:
        unpopulatedFields += [f"  = Unpopulated_{field:<7}"]
        # populatedfields += [f"  = {field}"]
    else:
        unpopulatedFields += [f"  | Unpopulated_{field:<7}"]
        # populatedfields += [f"  | {field}"]

generated_hs = \
f'''{{-# LANGUAGE DataKinds #-}}
{{-# LANGUAGE NumericUnderscores #-}}

module ExtractField() where

import Clash.Prelude
import Fields(UnpopulatedField(..), PopulatedField(..))
import Util(powerIndex32)
import Types(Insn)

'''

with open(hs_out, 'w') as f:
    f.write(generated_hs)