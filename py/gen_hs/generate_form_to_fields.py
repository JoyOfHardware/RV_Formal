import sys
import json

forms_v_field = sys.argv[1]
hs_out = sys.argv[2]

with open(forms_v_field, 'r') as f:
    forms_v_field_dict = json.loads(f.read())

functionVariants = []
for form, fields in forms_v_field_dict.items():
    list_of_fields = ['Unpopulated_'+field for field in fields]
    list_of_fields = f"[{', '.join(list_of_fields)}]"
    functionVariants += [f"formToField {form} = {list_of_fields}"]

generated_hs = \
f'''module Decode.FormToField(formToField) where

import Decode.Fields(UnpopulatedField(..))
import Decode.Forms(Form(..))
import Clash.Prelude

formToField :: Form -> [UnpopulatedField]
{'\n'.join(functionVariants)}
'''

with open(hs_out, 'w') as f:
    f.write(generated_hs)