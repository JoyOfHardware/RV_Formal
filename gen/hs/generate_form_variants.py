import sys
from .. import isa

generated_haskell_filename = sys.argv[1]

def gen_hs(forms_v_fields):
    form_definitions = []
    main_form = []
    export_list = []

    # Determine the maximum field name length for alignment
    max_field_length = max(len(f"{form_name.lower()}{field_name}") for form_name, fields in forms_v_fields.items() for field_name, _ in fields.items())

    for form_name, fields in forms_v_fields.items():
        fields_str = []
        field_exports = []
        for field_name, (start, end) in fields.items():
            width = end - start + 1
            field_name_formatted = f"{form_name.lower()}{field_name}"
            fields_str.append(f"  {field_name_formatted.ljust(max_field_length)} :: Unsigned {width}")
            field_exports.append(field_name_formatted)
        # Define each form variant
        form_type_name = f"Form{form_name}"

        form_definition = \
f"""
data {form_type_name} = {form_type_name} {{
{',\n'.join(fields_str) }
}} deriving (Generic, Show, Eq, NFDataX)"""

        form_definitions.append(form_definition)
        # Add to the main Form type
        main_form.append(f"{form_name} (FormState {form_type_name})")
        # Export statement for the type and its fields
        exports = ", ".join([form_type_name] + field_exports)
        export_list.append(f"  , {form_type_name}({exports})")

    # Complete the module header with exports
    haskell_code = \
f"""{{-# LANGUAGE RecordWildCards #-}}
{{-# LANGUAGE DataKinds #-}}
{{-# LANGUAGE NumericUnderscores #-}}

module Forms (
    Form(..)
  , FormState(..)
{'\n'.join(export_list)}
   ) where

import Clash.Prelude

data FormState a = Unpopulated | Populated a
  deriving (Generic, Show, Eq, NFDataX)

data Form
  = {'\n  | '.join(main_form)}
  deriving (Generic, Show, Eq, NFDataX)

{'\n'.join(form_definitions)}"""

    return haskell_code

haskell_code = gen_hs(isa.forms_v_fields)

with open(generated_haskell_filename, 'w') as f:
    f.write(haskell_code)