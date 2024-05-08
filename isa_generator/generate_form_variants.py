import pandas as pd
import sys

spreadsheet_filename       = sys.argv[1]
generated_haskell_filename = sys.argv[2]

instruction_forms = pd.read_excel(
    spreadsheet_filename,
    sheet_name='instruction_forms'
    ).fillna(method='ffill', axis=1)

def is_consecutive(l):
    # makes sure all elements in list are consecutive integers
    diff = [(lhs - rhs) == 1 for lhs,rhs in zip(l[1:],l[:-1])]
    for el in diff:
        if not el:
            return False
    
    return True

form_dict = {}
forms_with_split_fields = []
for index, form in enumerate(instruction_forms.Format):
    form_dict[form]={}
    
    for field in instruction_forms.iloc[index, 1:].unique():
        
        # skip 'dots', 'PO' which is the opcode field, or 'XO' 
        # which is extended opcode
        if field in {'.', 'XO', 'PO'}:
            continue

        bit_list = (instruction_forms.columns[instruction_forms.iloc[index, :] == field]).tolist()
        if is_consecutive(bit_list):
            form_dict[form][field] = (bit_list[0], bit_list[-1])
        
        else:
            forms_with_split_fields += [form]

def generate_haskell_code(data):
    haskell_code = """\
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE NumericUnderscores #-}

module Forms
  ( Form(..)"""

    form_definitions = []
    main_form = []
    export_list = []

    # Determine the maximum field name length for alignment
    max_field_length = max(len(f"{form_name.lower()}{field_name}") for form_name, fields in data.items() for field_name, _ in fields.items())

    for form_name, fields in data.items():
        fields_str = []
        field_exports = []
        for field_name, (start, end) in fields.items():
            width = end - start + 1
            field_name_formatted = f"{form_name.lower()}{field_name}"
            fields_str.append(f"  {field_name_formatted.ljust(max_field_length)} :: Unsigned {width}")
            field_exports.append(field_name_formatted)
        # Define each form variant
        form_type_name = f"Form{form_name}"
        form_definition = f"data {form_type_name} = {form_type_name} {{" + ",\n".join(fields_str) + " }\n  deriving (Generic, Show, Eq, NFDataX)"
        form_definitions.append(form_definition)
        # Add to the main Form type
        main_form.append(f"{form_name} {form_type_name}")
        # Export statement for the type and its fields
        exports = ", ".join([form_type_name] + field_exports)
        export_list.append(f"  , {form_type_name}({exports})")

    # Complete the module header with exports
    haskell_code += "\n".join(export_list) + "\n  ) where\n\nimport Clash.Prelude\n"

    haskell_code += "\ndata Form\n  = " + "\n  | ".join(main_form)
    haskell_code += "\n  deriving (Generic, Show, Eq, NFDataX)\n\n"
    
    haskell_code += "\n\n".join(form_definitions)

    return haskell_code

haskell_code = generate_haskell_code(form_dict)

with open(generated_haskell_filename, 'w') as f:
    f.write(haskell_code)