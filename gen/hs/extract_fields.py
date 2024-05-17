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
getField{field} :: Insn -> Unsigned {field_bitlen}
getField{field} insn = unpack $ slice (powerIndex32 @{slice[0]}) (powerIndex32 @{slice[1]}) insn
"""
    )

populateFields = []
for index, (field, slice) in enumerate(fields_v_slice_dict.items()):
    field_bitlen = slice[1] - slice[0] + 1
    populateFields.append(f"populateField Unpopulated_{field} insn = Populated_{field} $ getField{field} insn")

generated_hs = \
f'''{{-# LANGUAGE DataKinds #-}}
{{-# LANGUAGE NumericUnderscores #-}}

module ExtractField(populateField) where

import Clash.Prelude
import Fields(UnpopulatedField(..), PopulatedField(..))
import Util(powerIndex32)
import Types(Insn)

{''.join(getFieldFuncs)}

populateField :: UnpopulatedField -> Insn -> PopulatedField
{'\n'.join(populateFields)}
'''

with open(hs_out, 'w') as f:
    f.write(generated_hs)