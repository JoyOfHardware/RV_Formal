import sys
import json

forms_v_fields = sys.argv[1]
hs_out = sys.argv[2]

with open(forms_v_fields, 'r') as f:
    forms_v_fields_dict = json.loads(f.read())

forms = []

for index, (form, slice) in enumerate(forms_v_fields_dict.items()):
    if index == 0:
        forms += [f"  = {form}"]
    else:
        forms += [f"  | {form}"]

generated_hs = \
f'''{{-# LANGUAGE DataKinds #-}}
{{-# LANGUAGE NumericUnderscores #-}}

module Forms(Form(..)) where
import Clash.Prelude

data Form
{'\n'.join(forms)}
  deriving (Generic, Show, Eq, NFDataX)
'''

with open(hs_out, 'w') as f:
    f.write(generated_hs)